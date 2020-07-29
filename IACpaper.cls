%% ==================================================
%% Author: Rafael Rodrigues Luz Benevides
%% Email: rafaeluz821@gmail.com
%% ==================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{IACpaper}[2020/07/28 - LaTeX template for the International Astronautical Congress - Rafael R. L. Benevides]
\LoadClass[twocolumn, 10pt]{article}

\RequirePackage[a4paper, lmargin=2.25cm, rmargin=2.25cm, tmargin=3.35cm, bmargin=3.35cm]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage[super]{nth}
\RequirePackage{times}
\RequirePackage{float}
\RequirePackage{caption}
\RequirePackage{makecell}
\RequirePackage{tabularx}
%% -------------------------------------------------- don't change this order
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amstext}
\RequirePackage{amsfonts}
\RequirePackage{bm}
%% --------------------------------------------------
\RequirePackage{cleveref}
\RequirePackage[hang,flushmargin]{footmisc}
\RequirePackage{apptools}
\RequirePackage[backend=biber, sorting=none]{biblatex}
\RequirePackage{graphicx}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage[explicit,compact]{titlesec}
\RequirePackage{ifthen}


%% ================================================== macros
%% -------------------------------------------------- auxiliary variables
\newcounter{authorCounter}
\newcounter{keywordCounter}
\newif\ifcorrespondingAuthor

\correspondingAuthorfalse

%% -------------------------------------------------- paper authors
\newcommand\IACpaperauthor[3][none]{
	\stepcounter{authorCounter}
	\ifthenelse{\equal{#1}{corresponding}}{\correspondingAuthortrue}{}
	\@namedef{IAC@author@corresponding@\theauthorCounter}{#1}
	\@namedef{IAC@author@name@\theauthorCounter}{#2}
	\@namedef{IAC@author@institute@\theauthorCounter}{#3}
}

%% -------------------------------------------------- paper code
\newcommand\IACpapercode{\def\IAC@paper@code}

%% -------------------------------------------------- paper head
\newcommand\IACpaperhead{\def\IAC@paper@head}

%% -------------------------------------------------- paper abstract
\newcommand\IACpaperabstract{\def\IAC@paper@abstract}

%% -------------------------------------------------- paper keyword
\newcommand\IACpaperkeyword[1]{
	\stepcounter{keywordCounter}
	\@namedef{IAC@keyword@\thekeywordCounter}{#1}
}

%% -------------------------------------------------- print paper preamble
\newcommand\IACpaperpreamble{
	\twocolumn[
		\begin{@twocolumnfalse}
			\begingroup
				\global\@topnum\z@ % Prevents figures from going at top of page.
				\begin{minipage}{1.0\textwidth}

					\renewcommand\footnoterule{}
					\renewcommand\thempfootnote{\alph{mpfootnote}}
					\renewcommand\footnotesize{\it\normalsize}

					\begin{center}
						%% -------------------------------------------------- paper code
						\IAC@paper@code
						\vskip1em
						%% -------------------------------------------------- paper title
						\textbf{\@title}
						\vskip1em
						%% -------------------------------------------------- paper authors
						\@tempcnta=1
						\loop
							\ifthenelse{%
								\equal{\@nameuse{IAC@author@corresponding@\number\@tempcnta}}{corresponding}%
							}{%
								\textbf{\@nameuse{IAC@author@name@\number\@tempcnta}}%
								\footnote{\@nameuse{IAC@author@institute@\number\@tempcnta}}%
								$^*$%
							}{%
								\textbf{\@nameuse{IAC@author@name@\number\@tempcnta}}%
								\footnote{\@nameuse{IAC@author@institute@\number\@tempcnta}}%
							}%
							\ifnum\@tempcnta<\value{authorCounter}%
								\zap@space, \@empty\
								\advance\@tempcnta by 1%
						\repeat%
					\end{center}%
					\vskip1em
				\end{minipage}
				\ifcorrespondingAuthor%
					$^*$Corresponding Author
				\fi

				%% -------------------------------------------------- paper abstract
				\vskip1.5em
				\begin{center}
					\bf Abstract
				\end{center}

				\setlength{\parindent}{0.5cm}
				\IAC@paper@abstract\par
				%% -------------------------------------------------- keywords
				\noindent\textbf{Keywords:}
				\@tempcnta=1
				\loop
					\@nameuse{IAC@keyword@\number\@tempcnta}%
					\ifnum\@tempcnta<\value{keywordCounter}%
					\zap@space, \@empty\
					\advance\@tempcnta by 1%
				\repeat.
				%% --------------------------------------------------
				\vskip1em
			\endgroup
		\end{@twocolumnfalse}
	]

	%% -------------------------------------------------- set metadata
	\hypersetup{pdftitle={\@title}}
}

%% ================================================== remove head rule
\renewcommand{\headrulewidth}{0pt}

%% ================================================== set paragraph indent
\setlength\parindent{0.5cm}

%% ================================================== configure captions of fig and tables
\captionsetup[figure]{name=Fig., position=below, labelsep=period}
\captionsetup[table]{position=top, labelsep=period}

\setlength{\abovecaptionskip}{-10pt}
% \setlength{\abovecaptionskip}{-10pt}

%% ================================================== headings
%% -------------------------------------------------- sections
\titlespacing\section{0pt}{12pt plus 4pt minus 2pt}{2pt}
% \titleformat{\section}{\normalfont\bf}{\arabic{section}.}{0.7em}{\textbf{{#1}}}
\titleformat{\section}{\normalfont\bf}{%
	\IfAppendix{\appendixname\ \thesection }{\arabic{section}.}
}{\IfAppendix{0em}{0.5em}}{\textbf{#1}}

%% -------------------------------------------------- subsections
\titlespacing\subsection{0pt}{12pt plus 4pt minus 2pt}{2pt}
\titleformat{\subsection}{\normalfont\it}{\arabic{section}.\arabic{subsection}}{0.5em}{\it #1}

%% -------------------------------------------------- subsubsections
\titlespacing\subsubsection{0pt}{12pt plus 4pt minus 2pt}{2pt}
\titleformat{\subsubsection}{\normalfont\it}{\arabic{section}.\arabic{subsection}.\arabic{subsubsection}}{0.5em}{\it #1}

%% ================================================== At begin Document, run ...
\AtBeginDocument{

	\pagestyle{fancy}

	%% -------------------------------------------------- head
	\lhead{}
	\chead{\footnotesize \IAC@paper@head}
	\rhead{}

	%% -------------------------------------------------- foot
	\lfoot{\IAC@paper@code}
	\cfoot{}
	\rfoot{Page \thepage\ of \pageref{LastPage}}%
}
