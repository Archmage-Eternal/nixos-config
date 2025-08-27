{ pkgs, ... }:
{
  programs.zotero.enable = true;

  home.packages = with pkgs; [
    poppler_utils   # pdftotext/pdfinfo, nice for previews/extraction
    ocrmypdf        # OCR for scanned PDFs (optional)
  ];
}

