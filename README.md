# mkresume

### 🆕 What’s New (v1.0.2)

- ⚙️ **Optional DOCX generation:** use the new `--docx` flag to generate a Word version only when needed.  
- ✂️ **Added `--redacted` mode:** generate a phone-number-free version of your resume for public sharing.  
- 🧠 **Improved regex logic:** safely removes phone numbers while preserving pipes, parentheses, and line structure.  
- 🪄 **Backward compatible:** no breaking changes — standard usage remains the same.

---

**mkresume** is a lightweight, open-source resume builder for developers and professionals who prefer working in Markdown.  
It converts plain-text `.md` files into beautifully formatted, **ATS-friendly PDF** resumes — and optionally DOCX — fully automatable via GitHub Actions or local scripts.

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

### 2️⃣ Build a Resume (PDF only by default)

```bash
bash make_resume.sh examples/example_resume.md
```

This generates:
```
output/example_resume.pdf
```

To include a DOCX version, add `--docx`:
```bash
bash make_resume.sh examples/example_resume.md --docx
```

This generates:
```
output/example_resume.pdf
output/example_resume.docx
```

---

### 3️⃣ Generate a Redacted Version (No Phone Numbers)

You can build a version of your resume **without phone numbers** using the `--redacted` flag:

```bash
bash make_resume.sh examples/example_resume.md --redacted
```

Or combine both flags:
```bash
bash make_resume.sh examples/example_resume.md --redacted --docx
```

This produces:
```
output/example_resume_redacted.pdf
output/example_resume_redacted.docx
```

✅ Automatically removes phone number patterns such as:
```
+1(234)567-8910, (234)-567-8910, 234-567-8910
```
…while keeping all other text, links, and separators intact.

---

### 4️⃣ GitHub Action (optional)

A GitHub Actions workflow (`.github/workflows/build.yml`) can automatically build and upload both resume variants on every push or release tag.

---

## 🧩 Features

- 🧱 **Markdown → PDF (+ optional DOCX)** via Pandoc and XeLaTeX  
- 🧰 **Command-line and CI-friendly** automation  
- 🪄 **Redacted mode:** generate a phone-free version for public sharing (`--redacted` or `-r`)  
- ⚙️ **Optional DOCX output:** generate `.docx` only when `--docx` flag is passed  
- 🧹 **Safe formatting:** regex precisely removes phone numbers without breaking layout  
- 🎨 **Customizable LaTeX template** with Inter or Lato fonts  
- 🧰 **Extensible:** integrate with GitHub Actions, Makefiles, or CI/CD pipelines  
- 🌐 **Future-ready:** web interface and template gallery planned

---

## 📂 Project Structure

```
mkresume/
│
├── make_resume.sh               # CLI builder script (Pandoc + XeLaTeX + redacted/docx flags)
├── template.latex               # Custom LaTeX template
├── examples/
│   └── example_resume.md        # Sample resume
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
