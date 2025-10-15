# mkresume

### 🆕 What’s New (v1.2.0)

- ✂️ **Added `--redacted` mode:** generate a phone-number-free version of your resume for public sharing.  
- 🧠 **Improved regex logic:** safely removes phone numbers while preserving pipes, parentheses, and line structure.  
- 🧰 **Example format update:** simplified header contact line (single-line with `|` separators).  
- 🪄 **Backward compatible:** no breaking changes — standard usage remains the same.

---

**mkresume** is a lightweight, open-source resume builder for developers and professionals who prefer working in Markdown.  
It converts plain-text `.md` files into beautifully formatted, **ATS-friendly PDF and DOCX** resumes — fully automatable via GitHub Actions or local scripts.

---

## 🚀 Quick Start

### 1️⃣ Install Requirements

**Linux (Ubuntu/Debian):**
```bash
pip install -r requirements.txt
sudo apt-get install pandoc texlive-xetex -y
```

**macOS:**
```bash
brew install pandoc basictex
sudo tlmgr update --self
sudo tlmgr install titlesec xcolor enumitem hyperref url hyphenat changepage ragged2e
brew install --cask font-inter  # optional
brew install --cask font-lato   # optional
```

---

### 2️⃣ Build a Resume

Edit the sample file or use your own Markdown file:
```bash
bash make_resume.sh examples/example_resume.md
```

This generates:
```
output/example_resume.pdf
output/example_resume.docx
```

---

### 3️⃣ Generate a Redacted Version (No Phone Numbers)

You can now build a version of your resume **without phone numbers** — ideal for public uploads or portfolio sites — using the `--redacted` flag:

```bash
bash make_resume.sh examples/example_resume.md --redacted
```

This produces:
```
output/example_resume_redacted.pdf
output/example_resume_redacted.docx
```

✅ Automatically removes all phone number patterns such as:
```
+1(234)567-8910, (234)-567-8910, 234-567-8910
```
…while keeping all other text, links, and separators intact.

---

### 4️⃣ GitHub Action (optional)

A GitHub Actions workflow (`.github/workflows/build.yml`) can automatically build and upload both resume variants on every push or release tag.

---

## 🧩 Features

- 🧱 **Markdown → PDF + DOCX** via Pandoc and XeLaTeX  
- 🧰 **Command-line and CI-friendly** automation  
- 🪄 **Redacted mode:** generate a phone-free version for public sharing (`--redacted` or `-r`)  
- 🧹 **Safe formatting:** regex precisely removes phone numbers without breaking layout  
- 🎨 **Customizable LaTeX template** with Inter or Lato fonts  
- ⚙️ **Lightweight and privacy-first** — everything builds locally  
- 🧰 **Extensible:** integrate with GitHub Actions, Makefiles, or CI/CD pipelines  
- 🌐 **Future-ready:** web interface and template gallery planned

---

## 🧠 Example Use Case

Developers can maintain multiple Markdown resumes (e.g., `resume_ai.md`, `resume_qalead.md`) and optionally publish redacted versions for portfolio sites:

```bash
# Full private resume
bash make_resume.sh resume_ai.md

# Public-safe version
bash make_resume.sh resume_ai.md --redacted
```

Both versions are generated under `output/`.

---

## 📂 Project Structure

```
mkresume/
│
├── make_resume.sh               # CLI builder script (Pandoc + XeLaTeX + redacted mode)
├── template.latex               # Custom LaTeX template
├── examples/
│   └── example_resume.md        # Sample resume (Jane Doe, now single-line header format)
├── output/
│   ├── example_resume.pdf
│   ├── example_resume.docx
│   ├── example_resume_redacted.pdf
│   └── example_resume_redacted.docx
├── requirements.txt
└── LICENSE
```

---

### 🧑‍💻 Credits
**mkresume** was created and is maintained by [Wasif Mukaddam](https://wasifmukaddam.com).  
It’s built for developers and professionals who prefer writing their resumes in Markdown —  
with clean LaTeX templates, CLI automation, and GitHub Actions support.

Contributions, ideas, and pull requests are welcome!

---

### 📄 License
This project is [licensed](https://github.com/wasif-19/mkresume/blob/main/LICENSE) under the **MIT License**.  
© 2025 [Wasif Mukaddam](https://wasifmukaddam.com)
