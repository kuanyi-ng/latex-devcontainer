# Ref: https://github.com/ecofighter/uplatex-container
FROM debian:bullseye-slim as installer

ENV PATH /usr/local/bin/texlive:$PATH

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
  ca-certificates \
  perl \
  wget \
  xz-utils \
  fontconfig
RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -xzf ./install-tl-unx.tar.gz --strip-components=1
COPY ./install.profile ./
RUN perl ./install-tl -profile=install.profile
RUN ln -sf /usr/local/texlive/*/bin/* /usr/local/bin/texlive
RUN tlmgr install \
  lm \
  amsfonts \
  amsmath \
  mathtools \
  # rsfs \
  # jknapltx \
  tools \
  # `sttools` includes `stfloats`
  # `stfloats`: Commands to control the presentation of floats
  sttools \ 
  # physics \
  # braket \
  # The LATEX standard graphics bundle
#   latex-graphics \
  # The LATEX standard tools bundle
#   latex-tools \
  subfiles \
  standalone \
  # Classes tailored for use with Japanese
  jsclasses \
  everyhook \
  filehook \
  # svn-prov \
  kvoptions \
  infwarerr \
  # Create PostScript and PDF graphics in TEX
  pgf \
  pxpgfmark \
  # Hyperref support for pLATEX
  # pxjahyper \
  # Automated patches for pLATEX/upLATEX
  # plautopatch \
  # platex-tools \
  # Japanese document class based on requirements for Japanese text layout
  jlreq \
  jlreq-deluxe \
  # Advanced font selection for platex and its friends
  japanese-otf \
  # A LATEX class for producing presentations and slides
  # beamer \
  # bxdpx-beamer \
  # pLATEX2ε and miscellaneous macros for upTEX
  # uplatex \
  dvipdfmx \
  adobemapping \
  haranoaji \
  haranoaji-extra \
  # Font maps and configuration tools for Japanese/Chinese/Korean fonts with (u)ptex
  # ptex-fontmaps \
  # An automation tool for running LATEX
  # cluttex
  # A comprehensive (SI) units package
  siunitx \
  # Verbatim with URL-sensitive line breaks
  url \
  # Create tabular cells spanning multiple rows
  multirow \
  # Selectively include/exclude portions of text
  comment \
  # Customising captions in floating environments (comes with `subcaption`)
  caption

# RUN kanji-config-updmap-sys haranoaji
RUN wget https://github.com/jgm/pandoc/releases/download/3.1.2/pandoc-3.1.2-linux-amd64.tar.gz
RUN tar -xzf pandoc-3.1.2-linux-amd64.tar.gz
RUN cp ./pandoc-3.1.2/bin/pandoc /usr/local/bin/

FROM debian:bullseye-slim

ENV PATH=/usr/local/bin/texlive:$PATH
ENV DEBIAN_FRONTEND=noninteractive

COPY --from=installer /usr/local/texlive /usr/local/texlive
COPY --from=installer /usr/local/bin/pandoc /usr/local/bin/pandoc
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  perl \
  wget \
  git \
  locales \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* \
  && ln -sf /usr/local/texlive/*/bin/* /usr/local/bin/texlive

# locale の設定
# https://zenn.dev/sjh4/articles/23e130cb73d939
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
  && locale-gen