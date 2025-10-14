#!/usr/bin/env python3
import argparse, subprocess, sys, pathlib

def run(cmd):
  try:
    subprocess.run(cmd, check=True)
  except subprocess.CalledProcessError as e:
    sys.exit(e.returncode)

def main():
  p = argparse.ArgumentParser(description="mkresume builder (Pandoc + XeLaTeX)")
  p.add_argument("--input", "-i", default="examples/example_resume.md")
  p.add_argument("--template", "-t", default="examples/template.latex")
  p.add_argument("--metadata", "-m", default="examples/metadata.yaml")
  p.add_argument("--outdir", "-o", default="output")
  p.add_argument("--pdf-name", default="resume.pdf")
  p.add_argument("--docx-name", default="resume.docx")
  args = p.parse_args()

  outdir = pathlib.Path(args.outdir)
  outdir.mkdir(parents=True, exist_ok=True)

  run([
    "pandoc", args.input, "--from","markdown",
    "--template", args.template, "--metadata-file", args.metadata,
    "--pdf-engine","xelatex",
    "-o", str(outdir/args.pdf-name)
  ])
  run([
    "pandoc", args.input, "--from","markdown",
    "--metadata-file", args.metadata,
    "-o", str(outdir/args.docx-name)
  ])
  print(f"✅ PDF:  {outdir/args.pdf-name}\n✅ DOCX: {outdir/args.docx-name}")

if __name__ == "__main__":
  main()
