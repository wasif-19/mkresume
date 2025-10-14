# mkresume

**mkresume** is a lightweight, open-source resume builder for developers and professionals who prefer working in Markdown.  
It converts plain-text `.md` files into beautifully formatted, **ATS-friendly PDF and DOCX** resumes — fully automatable with GitHub Actions.

---

## 🚀 Quick Start

### 1️⃣ Install Requirements
```bash
pip install -r requirements.txt
sudo apt-get install pandoc texlive-xetex -y
```

### 2️⃣ Build a Resume

Edit examples/example_resume.md or use your own file:
```bash
make_resume.sh examples/example_resume.md
```

This generates:
```
output/resume.pdf
output/resume.docx
```

### 3️⃣ GitHub Action (optional)
Automatically build and upload resume PDFs with each commit — see .github/workflows/build.yml.


### 🧩 Local Setup

1. **Install dependencies (macOS)**:
   ```bash
   brew install pandoc basictex
   sudo tlmgr update --self
   sudo tlmgr install titlesec xcolor enumitem hyperref url hyphenat changepage ragged2e
   brew install --cask font-inter  # optional
   brew install --cask font-lato  # optional

2.	**Build your resume**:
    ```bash
    bash make_resume.sh

Outputs will appear in /output/resume.pdf and /output/resume.docx.


### 🧩 Features:
	•	🧱 Markdown → PDF + DOCX (via Pandoc)
	•	🧰 Command-line and CI-friendly
	•	🎨 Custom LaTeX and DOCX templates
	•	🔒 Privacy-first (local data only)
	•	🌐 Optional future web interface

### 🧠 Example Use Case

Developers can maintain multiple resumes (e.g., resume_ai.md, resume_qalead.md) in version control, run:
```bash
bash make_resume.sh resume_ai.md
```
and instantly generate tailored resumes for different roles.

### 📄 License

MIT License — © 2025 Wasif Mukaddam

---