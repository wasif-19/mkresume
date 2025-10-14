![Build Example Resume](https://github.com/wasifmukaddam/mkresume/actions/workflows/build_demo.yml/badge.svg)

# mkresume

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
output/resume.pdf
output/resume.docx
```

---

### 3️⃣ GitHub Action (optional)

A GitHub Actions workflow (`.github/workflows/build.yml`) can automatically build and upload your resume PDF/DOCX on every push or release tag.

---

## 🧩 Features

- 🧱 **Markdown → PDF + DOCX** via Pandoc and XeLaTeX  
- 🧰 **Command-line and CI-friendly** automation  
- 🎨 **Customizable LaTeX template** with Inter or Lato fonts  
- ⚙️ **Lightweight and privacy-first** — everything builds locally  
- 🪄 **Extensible**: integrate with GitHub Actions, Makefiles, or CI/CD  
- 🌐 **Future-ready**: web interface and template gallery planned

---

## 🧠 Example Use Case

Developers can maintain multiple Markdown resumes (e.g., `resume_ai.md`, `resume_qalead.md`) under version control, then run:

```bash
bash make_resume.sh resume_ai.md
```

to instantly generate tailored resumes for different roles.

---

## 📂 Project Structure

```
mkresume/
│
├── make_resume.sh               # CLI builder script (Pandoc + XeLaTeX)
├── template.latex               # Custom LaTeX template
├── examples/
│   └── example_resume.md        # Public-safe sample resume (Jane Doe)
├── output/
│   ├── resume.pdf
│   └── resume.docx
├── requirements.txt
└── LICENSE
```

---

## 📄 License

MIT License © 2025 [Wasif Mukaddam](https://wasifmukaddam.com)
