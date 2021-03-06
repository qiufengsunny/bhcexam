% BHCexam.cls
%
% A LaTeX2e document class for preparing exams.

%% BHCexam.cls
%% Copyright (c) 2011-2019 BAO HONG CHANG
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.
%
% This work has the LPPL maintenance status "author-maintained".
% 
% This work consists of the files BHCexam.cls and BHCexamdoc.tex.
%
% The user's guide for exam.cls is in the file examdoc.tex.

%%% BAO HONG CHANG
%%% Math Crowd Inc.
%%% Shanghai
%%% charles@mathcrowd.cn

% The newest version of this documentclass should always be available
% from my web page: https://github.com/mathedu4all/bhcexam

\def\fileversion{1.02}
\def\filedate{2017/11/18}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{BHCexam}[\filedate\space Version \fileversion\space by
 BAO HONG CHANG]
 
 %                         *****************
 %                         **    OPIONS   **
 %                         *****************
 
 
 % Following options are available:
 
 % answers
 % adobe
 % ubuntu
 % windows



\newif\if@printanswers
\@printanswersfalse
\DeclareOption{answers}{\@printanswerstrue}

\newcommand\@fontsize{false}
\DeclareOption{csize5}{\renewcommand\@fontsize{5}}
\DeclareOption{csize4}{\renewcommand\@fontsize{-4}}


\newcommand\@fontset{adobe}
\DeclareOption{adobe}{\renewcommand\@fontset{adobe}}
\DeclareOption{ubuntu}{\renewcommand\@fontset{ubuntu}}
\DeclareOption{windows}{\renewcommand\@fontset{windowsnew}}



\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage[fontset = \@fontset, zihao = \@fontsize]{ctex}
\ctexset{linestretch = 4, autoindent = 0pt}


%                    *****************************
%                    **  EXTRA REQUIRED PACKAGE **
%                    *****************************

\RequirePackage{amsmath,amssymb,amsthm,bm,bbding,mathtools,txfonts,yhmath,pifont,ifthen}
\RequirePackage{paralist,cases,tabularx,romannum}
\RequirePackage{pstricks,pst-plot,xcolor,graphicx}
\RequirePackage{geometry,caption}
\captionsetup[figure]{font=small,belowskip=-25pt}

\AtBeginDocument{\pagenumbering{arabic}}


%                         *****************
%                         ** PAGE LAYOUT **
%                         *****************

\RequirePackage{geometry,fancyhdr}
\RequirePackage{etoolbox}

\geometry{hmargin={2cm,2cm},vmargin={2cm,2cm}}
\setlength{\marginparwidth}{2cm}
\renewcommand{\headrulewidth}{0pt}
\renewcommand*{\title}[1]{\gdef\@title{#1}}
\newcommand*{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand*{\notice}[1]{\gdef\@notice{#1}}
\renewcommand*{\author}[1]{\gdef\@author{#1}}
\renewcommand*{\date}[1]{\gdef\@date{#1}}
\newcommand*{\logo}[1]{\gdef\@logo{#1}}
\renewcommand\maketitle{\begingroup
	\renewcommand{\baselinestretch}{2}
	\newpage
	\IfFileExists{\@logo}{
		\begin{minipage}{0.1\textwidth}
			\includegraphics[width=1.5cm]{\@logo}
		\end{minipage}
	}{}
	\begin{minipage}{0.9\textwidth}
	\begin{center}
		\heiti \Large
		\@title \par
		\@subtitle \par
		\ifdefempty{\@notice}{}{
			\fbox{\normalsize \@notice} \par
		}
		\songti \normalsize \@author \par
	\end{center}
	\end{minipage}
	\begin{flushright}
		\small \@date \par
	\end{flushright}
	\songti \normalsize
\endgroup}

\renewcommand\arraystretch{1.5}
\renewcommand{\baselinestretch}{1.5}

%                    ***************************
%                    ** QUESTION ENVIRONMENTS **
%                    ***************************

\newcounter{Group}
\newcounter{Question}
\newcounter{Example}
\newcounter{Exercise}
\newcounter{Subquestion}[Question]
\newcounter{Method}[Question]
\newif\if@showscore
\@showscorefalse
\newif\if@showskip
\@showskipfalse
\newlength{\myvertspace}

\newenvironment{groups}{
	\par \begingroup
}{
	\par \endgroup \par
}

\newcommand{\group}[2]{
	\stepcounter{Group} \vspace{5mm} \par \heiti{\par \chinese{Group} 、#1} \quad \small{\kaishu #2} \songti \normalsize
}

\newenvironment{questions}[1][]{
	\@tfor \@opt :=#1\do
		{\if\@opt s\global\@showscoretrue\fi
		 \if\@opt t\global\@showskiptrue\fi}
	\par \begingroup \par
}{
	\par \endgroup \par
	\global\@showscorefalse
	\global\@showskipfalse
}

\newcommand{\question}[1][0]{
	\stepcounter{Question} \vspace{5mm} \par \arabic{Question}.  \if@showscore \kaishu ( #1 分) \songti \fi
}

\newcommand{\example}[1][0]{
	\stepcounter{Example} \vspace{5mm} \par 例题\arabic{Example}.  \if@showscore \kaishu ( #1 分) \songti \fi
}

\newcommand{\exercise}[1][0]{
	\stepcounter{Exercise} \vspace{5mm} \par 习题\arabic{Exercise}.  \if@showscore \kaishu ( #1 分) \songti \fi
}


\newenvironment{subquestions}{
	\par \songti \begingroup \par
}{
	\par \endgroup \par
}

\newcommand{\subquestion}[1][0]{
	\stepcounter{Subquestion} \par (\arabic{Subquestion}) 
} 

\newenvironment{solution}[1]{
	\setlength{\myvertspace}{#1}
	\par \if@printanswers \par \color{red} \begingroup \else \if@showskip \vspace*{\myvertspace} \fi \setbox\z@\vbox\bgroup\fi \songti
}{
	\par \if@printanswers \endgroup \color{black} \else \egroup \fi \par
}

\newcommand{\hint}{
	\par \fbox{\heiti{提示}} \par \songti
}
\newcommand{\method}{
	\stepcounter{Method}
	\par \fbox{\heiti{解法\chinese{Method}}} \par \songti
}
	
\newcommand{\methodonly}{
	\par \fbox{\heiti{解答}} \par \songti
}

\newcommand{\score}[2]{
	\par
	\dotfill 本步骤 #1 分， 累计 #2 分
	\par}

\makeatletter
\newcommand{\build}[2]{\leavevmode
	\count@=\z@ \toks@={}%
	\loop\ifnum\count@<\numexpr#1\relax
	\toks@=\expandafter{\the\toks@#2}%
	\advance\count@\@ne
	\repeat
	\the\toks@}
\makeatletter

\newlength{\keylength}
\newcommand{\key}[1]{
	\if@printanswers
	\underline{~~#1~~}
	\else
	\settowidth{\keylength}{~~#1~~}
	\build{13}{\hskip1sp\kern-1sp\hbox to 0.1\keylength{\hrulefill}}
%	\underline{~\hspace{1.3\keylength}~}
	\fi}

\newcommand{\onech}[4]{
	\par
	\begin{tabularx}{\linewidth}{XXXX}
		\setlength\tabcolsep{0pt}
		(A) #1 & (B) #2 & (C) #3 & (D) #4 \\
	\end{tabularx}
	\unskip \unskip}
\newcommand{\twoch}[4]{
	\par
	\begin{tabularx}{\linewidth}{XX}
		\setlength\tabcolsep{0pt}
		(A) #1 & (B) #2 \\
		(C) #3 & (D) #4
	\end{tabularx}
	\unskip \unskip}
\newcommand{\fourch}[4]{
	\par
	\begin{tabularx}{\linewidth}{X}
		\setlength\tabcolsep{0pt}
		(A) #1 \\
		(B) #2 \\
		(C) #3 \\
		(D) #4 \\
	\end{tabularx}
	\unskip \unskip}

\newlength{\choicelengtha}
\newlength{\choicelengthb}
\newlength{\choicelengthc}
\newlength{\choicelengthd}
\newlength{\choicelengthe}
\newlength{\maxlength}

\newcommand{\fourchoices}[4]
{
	\par
	\settowidth{\choicelengtha}{A.~#1~~~}
	\settowidth{\choicelengthb}{B.~#2~~~}
	\settowidth{\choicelengthc}{C.~#3~~~}
	\settowidth{\choicelengthd}{D.~#4~~~}
	\ifthenelse{\lengthtest{\choicelengtha>\choicelengthb}}{\setlength{\maxlength}{\choicelengtha}}{\setlength{\maxlength}{\choicelengthb}}
	\ifthenelse{\lengthtest{\choicelengthc>\maxlength}}{\setlength{\maxlength}{\choicelengthc}}{}
	\ifthenelse{\lengthtest{\choicelengthd>\maxlength}}{\setlength{\maxlength}{\choicelengthd}}{}
	\ifthenelse{\lengthtest{\maxlength>0.5\linewidth}}
	{
		\begin{tabularx}{\linewidth}{X}
			\setlength\tabcolsep{0pt}
			A.~#1~~~\\
			B.~#2~~~\\
			C.~#3~~~\\
			D.~#4~~~\\
		\end{tabularx}
	}
	{
		\ifthenelse{\lengthtest{\maxlength>0.25\linewidth}}
		{
			\begin{tabularx}{\linewidth}{XX}
				\setlength\tabcolsep{0pt}
				A.~#1~~~ & B.~#2~~~\\
				C.~#3~~~ & D.~#4~~~\\
			\end{tabularx}
		}
		{
			\begin{tabularx}{\linewidth}{XXXX}
				\setlength\tabcolsep{0pt}
				A.~#1~~~  & B.~#2~~~ & C.~#3~~~ & D.~#4~~~\\ 
			\end{tabularx}
		}
	}
	\unskip \unskip 
}

\newcommand{\fivechoices}[5]
{
	\par
	\settowidth{\choicelengtha}{A.~#1~~~}
	\settowidth{\choicelengthb}{B.~#2~~~}
	\settowidth{\choicelengthc}{C.~#3~~~}
	\settowidth{\choicelengthd}{D.~#4~~~}	\settowidth{\choicelengthe}{D.~#5~~~}
	\ifthenelse{\lengthtest{\choicelengtha>\choicelengthb}}{\setlength{\maxlength}{\choicelengtha}}{\setlength{\maxlength}{\choicelengthb}}
	\ifthenelse{\lengthtest{\choicelengthc>\maxlength}}{\setlength{\maxlength}{\choicelengthc}}{}
	\ifthenelse{\lengthtest{\choicelengthd>\maxlength}}{\setlength{\maxlength}{\choicelengthd}}{}	\ifthenelse{\lengthtest{\choicelengthe>\maxlength}}{\setlength{\maxlength}{\choicelengthe}}{}
	
	\ifthenelse{\lengthtest{\maxlength>0.5\linewidth}}
	{
		\begin{tabularx}{\linewidth}{X}
			\setlength\tabcolsep{0pt}
			A.~#1~~~\\
			B.~#2~~~\\
			C.~#3~~~\\
			D.~#4~~~\\
			E.~#5~~~\\
		\end{tabularx}
	}
	{
		\ifthenelse{\lengthtest{\maxlength>0.33\linewidth}}
		{
			\begin{tabularx}{\linewidth}{XX}
				\setlength\tabcolsep{0pt}
				A.~#1~~~ & B.~#2~~~\\
				C.~#3~~~ & D.~#4~~~\\
				E.~#5~~~ &         \\
			\end{tabularx}
		}
		{
			\ifthenelse{\lengthtest{\maxlength>0.2\linewidth}}
			{
				\begin{tabularx}{\linewidth}{XXX}
					\setlength\tabcolsep{0pt}
					A.~#1~~~  & B.~#2~~~ & C.~#3~~~\\
					D.~#4~~~  & E.~#2~~~ &         \\
				\end{tabularx}
			}
			{
				\begin{tabularx}{\linewidth}{XXXXX}
					\setlength\tabcolsep{0pt}
					A.~#1~~~  & B.~#2~~~ & C.~#3~~~ & D.~#4~~~  & E.~#2~~~\\
				\end{tabularx}
			}

		}
	}
	\unskip \unskip 
}


%                    ***************************
%                    **   CUSTOMIZED COMMAND  **
%                    ***************************

\newcommand\abs[1]{\left|#1\right|}
\newcommand{\gt}{>}
\newcommand{\lt}{<}
\newcommand\overparen[1]{\wideparen{#1}}
\renewcommand{\geq}{\geqslant}
\renewcommand{\ge}{\geqslant}
\renewcommand{\leq}{\leqslant}
\renewcommand{\le}{\leqslant}
\renewenvironment{split}{\begin{aligned}}{\end{aligned}}

\endinput
