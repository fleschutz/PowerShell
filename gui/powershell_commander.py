#!/usr/bin/env python3
"""
PowerShell Commander - A Modern Dark-Themed GUI for PowerShell Scripts
Built with CustomTkinter for a sleek, modern interface
"""

import customtkinter as ctk
import subprocess
import threading
import json
import os
import sys
from pathlib import Path
from typing import Dict, List, Optional, Callable
import queue


class ScriptConfig:
    """Manages script configuration and assignments to categories"""

    def __init__(self, config_path: str):
        self.config_path = Path(config_path)
        self.scripts_dir = Path(__file__).parent.parent / "scripts"
        self.dump_dir = Path(__file__).parent / "script_dump"
        self.config = self._load_config()

        # Ensure dump directory exists
        self.dump_dir.mkdir(exist_ok=True)

    def _load_config(self) -> dict:
        """Load configuration from JSON file"""
        if self.config_path.exists():
            with open(self.config_path, 'r') as f:
                return json.load(f)
        return self._create_default_config()

    def _create_default_config(self) -> dict:
        """Create default configuration with categories"""
        config = {
            "categories": {
                "Files": {
                    "icon": "📁",
                    "description": "File and folder operations",
                    "scripts": []
                },
                "Computer": {
                    "icon": "💻",
                    "description": "System management and monitoring",
                    "scripts": []
                },
                "Network": {
                    "icon": "🌐",
                    "description": "Network and DNS operations",
                    "scripts": []
                },
                "Audio": {
                    "icon": "🔊",
                    "description": "Sound and speech operations",
                    "scripts": []
                },
                "Apps": {
                    "icon": "📦",
                    "description": "Application management",
                    "scripts": []
                },
                "Dev": {
                    "icon": "⚙️",
                    "description": "Development and Git tools",
                    "scripts": []
                },
                "Utils": {
                    "icon": "🔧",
                    "description": "Utility scripts",
                    "scripts": []
                },
                "Custom": {
                    "icon": "⭐",
                    "description": "Your custom scripts",
                    "scripts": []
                }
            },
            "window": {
                "width": 1200,
                "height": 800,
                "theme": "dark"
            },
            "scripts_per_row": 4
        }
        self.save_config(config)
        return config

    def save_config(self, config: dict = None):
        """Save configuration to JSON file"""
        if config:
            self.config = config
        self.config_path.parent.mkdir(parents=True, exist_ok=True)
        with open(self.config_path, 'w') as f:
            json.dump(self.config, f, indent=2)

    def get_all_scripts(self) -> List[str]:
        """Get all available PowerShell scripts"""
        scripts = []
        if self.scripts_dir.exists():
            scripts.extend([f.stem for f in self.scripts_dir.glob("*.ps1")])
        if self.dump_dir.exists():
            scripts.extend([f.stem for f in self.dump_dir.glob("*.ps1")])
        return sorted(set(scripts))

    def get_script_path(self, script_name: str) -> Optional[Path]:
        """Get the full path to a script"""
        # Check main scripts directory first
        main_path = self.scripts_dir / f"{script_name}.ps1"
        if main_path.exists():
            return main_path

        # Check dump directory
        dump_path = self.dump_dir / f"{script_name}.ps1"
        if dump_path.exists():
            return dump_path

        return None

    def add_script_to_category(self, category: str, script_name: str,
                                display_name: str = None, description: str = None):
        """Add a script to a category"""
        if category not in self.config["categories"]:
            return

        script_entry = {
            "name": script_name,
            "display_name": display_name or script_name.replace("-", " ").title(),
            "description": description or "",
            "requires_input": False,
            "input_prompts": []
        }

        # Check if already exists
        existing = [s for s in self.config["categories"][category]["scripts"]
                   if s["name"] == script_name]
        if not existing:
            self.config["categories"][category]["scripts"].append(script_entry)
            self.save_config()

    def remove_script_from_category(self, category: str, script_name: str):
        """Remove a script from a category"""
        if category not in self.config["categories"]:
            return
        self.config["categories"][category]["scripts"] = [
            s for s in self.config["categories"][category]["scripts"]
            if s["name"] != script_name
        ]
        self.save_config()


class OutputConsole(ctk.CTkFrame):
    """Console widget to display script output"""

    def __init__(self, parent, **kwargs):
        super().__init__(parent, **kwargs)

        self.configure(fg_color="#1a1a2e")

        # Header
        header = ctk.CTkFrame(self, fg_color="transparent")
        header.pack(fill="x", padx=5, pady=(5, 0))

        ctk.CTkLabel(header, text="📟 Output Console",
                     font=ctk.CTkFont(size=14, weight="bold")).pack(side="left")

        ctk.CTkButton(header, text="Clear", width=60, height=24,
                      command=self.clear).pack(side="right")

        # Text area with scrollbar
        self.text = ctk.CTkTextbox(self, fg_color="#0f0f1a",
                                    text_color="#00ff88",
                                    font=ctk.CTkFont(family="Consolas", size=12),
                                    wrap="word")
        self.text.pack(fill="both", expand=True, padx=5, pady=5)

        # Queue for thread-safe updates
        self.output_queue = queue.Queue()
        self._process_queue()

    def _process_queue(self):
        """Process queued output updates"""
        try:
            while True:
                text, color = self.output_queue.get_nowait()
                self.text.insert("end", text)
                self.text.see("end")
        except queue.Empty:
            pass
        self.after(100, self._process_queue)

    def append(self, text: str, color: str = None):
        """Append text to console (thread-safe)"""
        self.output_queue.put((text, color))

    def clear(self):
        """Clear the console"""
        self.text.delete("1.0", "end")

    def append_command(self, cmd: str):
        """Append a command header"""
        self.append(f"\n{'='*50}\n")
        self.append(f"▶ Running: {cmd}\n")
        self.append(f"{'='*50}\n\n")


class ScriptButton(ctk.CTkFrame):
    """A styled button for launching scripts"""

    def __init__(self, parent, script_info: dict, on_click: Callable, **kwargs):
        super().__init__(parent, **kwargs)

        self.script_info = script_info
        self.on_click = on_click

        self.configure(fg_color="#2d2d44", corner_radius=10)

        # Make clickable
        self.bind("<Button-1>", self._on_click)
        self.bind("<Enter>", self._on_enter)
        self.bind("<Leave>", self._on_leave)

        # Script name
        name_label = ctk.CTkLabel(
            self,
            text=script_info.get("display_name", script_info["name"]),
            font=ctk.CTkFont(size=13, weight="bold"),
            text_color="#ffffff"
        )
        name_label.pack(padx=10, pady=(10, 2))
        name_label.bind("<Button-1>", self._on_click)

        # Description
        desc = script_info.get("description", "")
        if desc:
            desc_label = ctk.CTkLabel(
                self,
                text=desc[:50] + ("..." if len(desc) > 50 else ""),
                font=ctk.CTkFont(size=10),
                text_color="#888899"
            )
            desc_label.pack(padx=10, pady=(0, 5))
            desc_label.bind("<Button-1>", self._on_click)

        # Run button
        run_btn = ctk.CTkButton(
            self,
            text="▶ Run",
            width=80,
            height=28,
            fg_color="#4a4a6a",
            hover_color="#6a6a8a",
            command=lambda: self.on_click(script_info)
        )
        run_btn.pack(pady=(5, 10))

    def _on_click(self, event=None):
        self.on_click(self.script_info)

    def _on_enter(self, event=None):
        self.configure(fg_color="#3d3d54")

    def _on_leave(self, event=None):
        self.configure(fg_color="#2d2d44")


class InputDialog(ctk.CTkToplevel):
    """Dialog for interactive script input"""

    def __init__(self, parent, prompts: List[dict], script_name: str):
        super().__init__(parent)

        self.title(f"Input Required - {script_name}")
        self.geometry("400x300")
        self.configure(fg_color="#1a1a2e")

        self.results = {}
        self.cancelled = True

        # Center on parent
        self.transient(parent)
        self.grab_set()

        # Title
        ctk.CTkLabel(
            self,
            text=f"📝 {script_name}",
            font=ctk.CTkFont(size=16, weight="bold")
        ).pack(pady=(20, 10))

        # Input fields
        self.entries = {}
        for prompt in prompts:
            frame = ctk.CTkFrame(self, fg_color="transparent")
            frame.pack(fill="x", padx=20, pady=5)

            ctk.CTkLabel(
                frame,
                text=prompt.get("label", prompt["name"]),
                font=ctk.CTkFont(size=12)
            ).pack(anchor="w")

            entry = ctk.CTkEntry(
                frame,
                placeholder_text=prompt.get("placeholder", ""),
                width=360
            )
            entry.pack(fill="x", pady=(2, 0))

            if prompt.get("default"):
                entry.insert(0, prompt["default"])

            self.entries[prompt["name"]] = entry

        # Buttons
        btn_frame = ctk.CTkFrame(self, fg_color="transparent")
        btn_frame.pack(fill="x", padx=20, pady=20)

        ctk.CTkButton(
            btn_frame,
            text="Cancel",
            fg_color="#4a4a6a",
            hover_color="#6a6a8a",
            command=self._cancel
        ).pack(side="left", padx=(0, 10))

        ctk.CTkButton(
            btn_frame,
            text="Run Script",
            fg_color="#2d8a4e",
            hover_color="#3da05e",
            command=self._submit
        ).pack(side="right")

        # Focus first entry
        if self.entries:
            list(self.entries.values())[0].focus()

        self.bind("<Return>", lambda e: self._submit())
        self.bind("<Escape>", lambda e: self._cancel())

    def _submit(self):
        self.results = {name: entry.get() for name, entry in self.entries.items()}
        self.cancelled = False
        self.destroy()

    def _cancel(self):
        self.cancelled = True
        self.destroy()


class ScriptManagerDialog(ctk.CTkToplevel):
    """Dialog for managing which scripts appear in each category"""

    def __init__(self, parent, config: ScriptConfig):
        super().__init__(parent)

        self.config = config
        self.title("Script Manager")
        self.geometry("900x600")
        self.configure(fg_color="#1a1a2e")

        self.transient(parent)
        self.grab_set()

        # Main layout
        self._create_layout()

    def _create_layout(self):
        # Header
        header = ctk.CTkFrame(self, fg_color="#2d2d44")
        header.pack(fill="x", padx=10, pady=10)

        ctk.CTkLabel(
            header,
            text="📦 Script Manager - Organize Your PowerShell Scripts",
            font=ctk.CTkFont(size=16, weight="bold")
        ).pack(pady=10)

        # Main content area
        content = ctk.CTkFrame(self, fg_color="transparent")
        content.pack(fill="both", expand=True, padx=10, pady=(0, 10))

        # Left panel - Available scripts
        left_panel = ctk.CTkFrame(content, fg_color="#2d2d44")
        left_panel.pack(side="left", fill="both", expand=True, padx=(0, 5))

        ctk.CTkLabel(
            left_panel,
            text="Available Scripts",
            font=ctk.CTkFont(size=14, weight="bold")
        ).pack(pady=10)

        # Search
        self.search_var = ctk.StringVar()
        self.search_var.trace("w", self._filter_scripts)

        search_entry = ctk.CTkEntry(
            left_panel,
            placeholder_text="🔍 Search scripts...",
            textvariable=self.search_var,
            width=280
        )
        search_entry.pack(padx=10, pady=(0, 10))

        # Script list
        self.script_listbox = ctk.CTkScrollableFrame(left_panel, fg_color="#1a1a2e")
        self.script_listbox.pack(fill="both", expand=True, padx=10, pady=(0, 10))

        self._populate_script_list()

        # Middle - buttons
        middle = ctk.CTkFrame(content, fg_color="transparent", width=80)
        middle.pack(side="left", fill="y", padx=5)
        middle.pack_propagate(False)

        # Category selector
        ctk.CTkLabel(middle, text="Category:").pack(pady=(50, 5))

        self.category_var = ctk.StringVar(value=list(self.config.config["categories"].keys())[0])
        self.category_menu = ctk.CTkOptionMenu(
            middle,
            variable=self.category_var,
            values=list(self.config.config["categories"].keys()),
            width=70
        )
        self.category_menu.pack(pady=(0, 20))

        ctk.CTkButton(
            middle, text="Add →", width=70,
            command=self._add_to_category
        ).pack(pady=5)

        ctk.CTkButton(
            middle, text="← Remove", width=70,
            fg_color="#8a2d4e",
            hover_color="#a03d5e",
            command=self._remove_from_category
        ).pack(pady=5)

        # Right panel - Category contents
        right_panel = ctk.CTkFrame(content, fg_color="#2d2d44")
        right_panel.pack(side="right", fill="both", expand=True, padx=(5, 0))

        ctk.CTkLabel(
            right_panel,
            text="Category Contents",
            font=ctk.CTkFont(size=14, weight="bold")
        ).pack(pady=10)

        self.category_listbox = ctk.CTkScrollableFrame(right_panel, fg_color="#1a1a2e")
        self.category_listbox.pack(fill="both", expand=True, padx=10, pady=(0, 10))

        self.category_var.trace("w", lambda *args: self._update_category_list())
        self._update_category_list()

        # Bottom buttons
        bottom = ctk.CTkFrame(self, fg_color="transparent")
        bottom.pack(fill="x", padx=10, pady=(0, 10))

        ctk.CTkButton(
            bottom, text="Done", width=100,
            command=self.destroy
        ).pack(side="right")

    def _populate_script_list(self, filter_text: str = ""):
        # Clear existing
        for widget in self.script_listbox.winfo_children():
            widget.destroy()

        scripts = self.config.get_all_scripts()

        if filter_text:
            scripts = [s for s in scripts if filter_text.lower() in s.lower()]

        for script in scripts[:100]:  # Limit for performance
            btn = ctk.CTkButton(
                self.script_listbox,
                text=script,
                anchor="w",
                fg_color="transparent",
                text_color="#cccccc",
                hover_color="#3d3d54",
                height=28
            )
            btn.pack(fill="x", pady=1)
            btn.configure(command=lambda s=script: self._select_script(s))

        self.selected_script = None

    def _filter_scripts(self, *args):
        self._populate_script_list(self.search_var.get())

    def _select_script(self, script_name: str):
        self.selected_script = script_name

    def _add_to_category(self):
        if hasattr(self, 'selected_script') and self.selected_script:
            category = self.category_var.get()
            self.config.add_script_to_category(
                category,
                self.selected_script,
                self.selected_script.replace("-", " ").title()
            )
            self._update_category_list()

    def _remove_from_category(self):
        if hasattr(self, 'selected_category_script') and self.selected_category_script:
            category = self.category_var.get()
            self.config.remove_script_from_category(category, self.selected_category_script)
            self._update_category_list()

    def _update_category_list(self):
        # Clear existing
        for widget in self.category_listbox.winfo_children():
            widget.destroy()

        category = self.category_var.get()
        scripts = self.config.config["categories"].get(category, {}).get("scripts", [])

        for script in scripts:
            btn = ctk.CTkButton(
                self.category_listbox,
                text=script.get("display_name", script["name"]),
                anchor="w",
                fg_color="transparent",
                text_color="#88ff88",
                hover_color="#3d3d54",
                height=28
            )
            btn.pack(fill="x", pady=1)
            btn.configure(command=lambda s=script["name"]: self._select_category_script(s))

        self.selected_category_script = None

    def _select_category_script(self, script_name: str):
        self.selected_category_script = script_name


class PowerShellCommander(ctk.CTk):
    """Main application window"""

    def __init__(self):
        super().__init__()

        # Configure CustomTkinter
        ctk.set_appearance_mode("dark")
        ctk.set_default_color_theme("blue")

        # Load configuration
        config_path = Path(__file__).parent / "config" / "scripts_config.json"
        self.config = ScriptConfig(config_path)

        # Window setup
        self.title("⚡ PowerShell Commander")
        self.geometry(f"{self.config.config['window']['width']}x{self.config.config['window']['height']}")
        self.configure(fg_color="#16162d")

        # Set minimum size
        self.minsize(800, 600)

        # Create UI
        self._create_header()
        self._create_main_content()
        self._create_status_bar()

        # Load default category
        self._load_category(list(self.config.config["categories"].keys())[0])

    def _create_header(self):
        """Create the header with title and controls"""
        header = ctk.CTkFrame(self, fg_color="#1a1a2e", height=60)
        header.pack(fill="x", padx=10, pady=10)
        header.pack_propagate(False)

        # Title
        ctk.CTkLabel(
            header,
            text="⚡ PowerShell Commander",
            font=ctk.CTkFont(size=24, weight="bold"),
            text_color="#ffffff"
        ).pack(side="left", padx=20, pady=10)

        # Controls on the right
        controls = ctk.CTkFrame(header, fg_color="transparent")
        controls.pack(side="right", padx=20)

        # Script Manager button
        ctk.CTkButton(
            controls,
            text="📦 Manage Scripts",
            width=140,
            fg_color="#4a4a6a",
            hover_color="#6a6a8a",
            command=self._open_script_manager
        ).pack(side="left", padx=5)

        # Refresh button
        ctk.CTkButton(
            controls,
            text="🔄",
            width=40,
            fg_color="#4a4a6a",
            hover_color="#6a6a8a",
            command=self._refresh
        ).pack(side="left", padx=5)

    def _create_main_content(self):
        """Create the main content area with categories and scripts"""
        main = ctk.CTkFrame(self, fg_color="transparent")
        main.pack(fill="both", expand=True, padx=10, pady=(0, 10))

        # Left sidebar - Categories
        sidebar = ctk.CTkFrame(main, fg_color="#1a1a2e", width=180)
        sidebar.pack(side="left", fill="y", padx=(0, 10))
        sidebar.pack_propagate(False)

        ctk.CTkLabel(
            sidebar,
            text="Categories",
            font=ctk.CTkFont(size=14, weight="bold")
        ).pack(pady=(15, 10))

        self.category_buttons = {}
        for cat_name, cat_info in self.config.config["categories"].items():
            btn = ctk.CTkButton(
                sidebar,
                text=f"{cat_info['icon']} {cat_name}",
                anchor="w",
                fg_color="transparent",
                text_color="#cccccc",
                hover_color="#3d3d54",
                height=36,
                command=lambda c=cat_name: self._load_category(c)
            )
            btn.pack(fill="x", padx=10, pady=2)
            self.category_buttons[cat_name] = btn

        # Spacer
        ctk.CTkFrame(sidebar, fg_color="transparent", height=20).pack(fill="x")

        # Quick actions
        ctk.CTkLabel(
            sidebar,
            text="Quick Actions",
            font=ctk.CTkFont(size=12, weight="bold"),
            text_color="#888899"
        ).pack(pady=(10, 5))

        quick_actions = [
            ("📁 Open Scripts", self._open_scripts_folder),
            ("📄 Open Dump", self._open_dump_folder),
            ("⚙️ Settings", self._open_settings),
        ]

        for text, cmd in quick_actions:
            ctk.CTkButton(
                sidebar,
                text=text,
                anchor="w",
                fg_color="transparent",
                text_color="#888899",
                hover_color="#3d3d54",
                height=30,
                command=cmd
            ).pack(fill="x", padx=10, pady=1)

        # Content area
        content_container = ctk.CTkFrame(main, fg_color="transparent")
        content_container.pack(side="left", fill="both", expand=True)

        # Scripts area (top)
        self.scripts_frame = ctk.CTkScrollableFrame(
            content_container,
            fg_color="#1a1a2e",
            label_text="",
            label_font=ctk.CTkFont(size=14, weight="bold")
        )
        self.scripts_frame.pack(fill="both", expand=True, pady=(0, 10))

        # Output console (bottom)
        self.console = OutputConsole(content_container, height=200)
        self.console.pack(fill="x")

    def _create_status_bar(self):
        """Create the status bar at the bottom"""
        self.status_bar = ctk.CTkFrame(self, fg_color="#1a1a2e", height=30)
        self.status_bar.pack(fill="x", padx=10, pady=(0, 10))
        self.status_bar.pack_propagate(False)

        self.status_label = ctk.CTkLabel(
            self.status_bar,
            text="Ready",
            font=ctk.CTkFont(size=11),
            text_color="#888899"
        )
        self.status_label.pack(side="left", padx=10, pady=5)

        # Script count
        total_scripts = len(self.config.get_all_scripts())
        ctk.CTkLabel(
            self.status_bar,
            text=f"📊 {total_scripts} scripts available",
            font=ctk.CTkFont(size=11),
            text_color="#888899"
        ).pack(side="right", padx=10, pady=5)

    def _load_category(self, category: str):
        """Load scripts for a category"""
        # Update button highlighting
        for name, btn in self.category_buttons.items():
            if name == category:
                btn.configure(fg_color="#3d3d54", text_color="#ffffff")
            else:
                btn.configure(fg_color="transparent", text_color="#cccccc")

        # Clear current scripts
        for widget in self.scripts_frame.winfo_children():
            widget.destroy()

        # Get category info
        cat_info = self.config.config["categories"].get(category, {})
        scripts = cat_info.get("scripts", [])

        # Update frame label
        self.scripts_frame.configure(
            label_text=f"{cat_info.get('icon', '📁')} {category} - {cat_info.get('description', '')}"
        )

        if not scripts:
            # Show empty state
            empty_frame = ctk.CTkFrame(self.scripts_frame, fg_color="transparent")
            empty_frame.pack(expand=True, pady=50)

            ctk.CTkLabel(
                empty_frame,
                text="No scripts in this category yet",
                font=ctk.CTkFont(size=14),
                text_color="#666677"
            ).pack()

            ctk.CTkButton(
                empty_frame,
                text="📦 Add Scripts",
                command=self._open_script_manager
            ).pack(pady=10)
            return

        # Create grid of scripts
        row_frame = None
        for i, script in enumerate(scripts):
            if i % self.config.config.get("scripts_per_row", 4) == 0:
                row_frame = ctk.CTkFrame(self.scripts_frame, fg_color="transparent")
                row_frame.pack(fill="x", pady=5, padx=5)

            btn = ScriptButton(
                row_frame,
                script,
                self._run_script,
                width=200,
                height=100
            )
            btn.pack(side="left", padx=5, pady=5)

        self._update_status(f"Loaded {len(scripts)} scripts in {category}")

    def _run_script(self, script_info: dict):
        """Run a PowerShell script"""
        script_name = script_info["name"]
        script_path = self.config.get_script_path(script_name)

        if not script_path:
            self.console.append(f"❌ Script not found: {script_name}\n")
            return

        # Check if script requires input
        if script_info.get("requires_input") and script_info.get("input_prompts"):
            dialog = InputDialog(self, script_info["input_prompts"], script_name)
            self.wait_window(dialog)

            if dialog.cancelled:
                return

            args = " ".join([f'-{k} "{v}"' for k, v in dialog.results.items() if v])
        else:
            args = ""

        # Build command
        if sys.platform == "win32":
            cmd = f'powershell.exe -ExecutionPolicy Bypass -File "{script_path}" {args}'
        else:
            # For Linux/WSL
            cmd = f'pwsh -File "{script_path}" {args}'

        self.console.append_command(f"{script_name}.ps1 {args}")
        self._update_status(f"Running: {script_name}...")

        # Run in thread to prevent UI freeze
        thread = threading.Thread(target=self._execute_script, args=(cmd, script_name))
        thread.daemon = True
        thread.start()

    def _execute_script(self, cmd: str, script_name: str):
        """Execute script in background thread"""
        try:
            process = subprocess.Popen(
                cmd,
                shell=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                bufsize=1
            )

            # Stream output
            for line in process.stdout:
                self.console.append(line)

            process.wait()

            if process.returncode == 0:
                self.console.append(f"\n✅ {script_name} completed successfully\n")
                self.after(0, lambda: self._update_status(f"✅ {script_name} completed"))
            else:
                self.console.append(f"\n⚠️ {script_name} exited with code {process.returncode}\n")
                self.after(0, lambda: self._update_status(f"⚠️ {script_name} failed"))

        except Exception as e:
            self.console.append(f"\n❌ Error: {str(e)}\n")
            self.after(0, lambda: self._update_status(f"❌ Error running {script_name}"))

    def _update_status(self, message: str):
        """Update status bar message"""
        self.status_label.configure(text=message)

    def _open_script_manager(self):
        """Open the script manager dialog"""
        dialog = ScriptManagerDialog(self, self.config)
        self.wait_window(dialog)
        # Refresh current category
        for name, btn in self.category_buttons.items():
            if btn.cget("fg_color") == "#3d3d54":
                self._load_category(name)
                break

    def _open_scripts_folder(self):
        """Open the scripts folder in file explorer"""
        path = self.config.scripts_dir
        if sys.platform == "win32":
            os.startfile(path)
        else:
            subprocess.run(["xdg-open", str(path)])

    def _open_dump_folder(self):
        """Open the dump folder in file explorer"""
        path = self.config.dump_dir
        path.mkdir(exist_ok=True)
        if sys.platform == "win32":
            os.startfile(path)
        else:
            subprocess.run(["xdg-open", str(path)])

    def _open_settings(self):
        """Open settings dialog"""
        # TODO: Implement settings dialog
        self.console.append("⚙️ Settings coming soon...\n")

    def _refresh(self):
        """Refresh the current view"""
        self.config = ScriptConfig(self.config.config_path)
        for name, btn in self.category_buttons.items():
            if btn.cget("fg_color") == "#3d3d54":
                self._load_category(name)
                break
        self._update_status("Refreshed")


def main():
    """Main entry point"""
    app = PowerShellCommander()
    app.mainloop()


if __name__ == "__main__":
    main()
