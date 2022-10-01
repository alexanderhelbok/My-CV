% this is inspired by Michael Pollind's Awesome CV 
\author{Alexander Helbok}
\date{\today}
\RequirePackage[dvipsnames]{xcolor} % moved here I guess article class causes option clash with xcolor if used after loading the class
\LoadClass[11pt, a4paper]{article}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{alex_cv}[2021/04/10 Alexander CV Class]
\RequirePackage[sfdefault]{noto}
\RequirePackage{etoolbox}
\RequirePackage{pgffor}
\RequirePackage{titlesec}
\RequirePackage{tikz}
\RequirePackage{fontspec}
\RequirePackage[left=0.75in,top=0.5in,right=0.75in,bottom=0.6in]{geometry} % Document margins
\RequirePackage{hyperref}
\RequirePackage{graphicx}
\RequirePackage{fontawesome5}
\RequirePackage{mfirstuc}
\RequirePackage{ifthen}
\RequirePackage{array}
\RequirePackage[super]{nth}
\pagestyle{empty}

%Setup

\graphicspath{ {./images/} }

\newcommand*{\setname}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\setmobile}[1]{\def\@mobile{#1}}
\newcommand*{\setposition}[1]{\def\@position{#1}}
\newcommand*{\setmail}[1]{\def\@mail{#1}}
\newcommand*{\setthemecolor}[1]{\def\@themecolor{#1}}
\newcommand*{\setlocation}[2]{\def\@city{#1}\def\@country{#2}}

%Setup for coverletter

\newcommand*{\setcompanyname}[1]{\def\@companyname{#1}}
\newcommand*{\setcontactperson}[1]{\def\@contactperson{#1}}
\newcommand*{\setclaimedposition}[1]{\def\@claimedposition{#1}}

\definecolor{alex}{HTML}{006898}

\hypersetup{
    colorlinks=true,
    urlcolor=cyan,
}

\setlength{\parindent}{0pt}

% View commands
% Header

% can makebox also be used?
\newcommand\headerview{
\begin{minipage}{0.25\linewidth}
    \profpic{0.3}{profilpicture1}
\end{minipage}% 
\hfill
\begin{minipage}{0.45\linewidth}
    \center \name \\[0.05cm] 
    \contact % address \ mobile \\ mail
\end{minipage}
}

%profilepicture

\newsavebox{\picbox}
\newcommand{\profpic}[2]{%
    \savebox{\picbox}{%
    \includegraphics[scale=#1]{#2}}% 
    \tikz\node [draw, circle,%
    line width=4pt, color=white,% 
    minimum width=\wd\picbox,minimum height=\ht\picbox,%
    path picture={ \node at (path picture bounding box.center)% 
    {\usebox{\picbox}};}]% 
    {};}
    
%contactsubviews 

\newcommand*{\setlinkedinaccount}[1]{\def\@linkedinaccount{#1}}
\newcommand*{\setgithubaccount}[1]{\def\@githubaccount{#1}}
\newcommand{\githubview}{\href{\@linkedinaccount}{\faLinkedin\ \footnotesize linkedin}}
\newcommand{\linkedinview}{\href{\@githubaccount}{\faGithubSquare\ \footnotesize github}}

\newcommand{\name}{%
    {\LARGE \@firstname \ \textsc{\@lastname}}
}

\newcommand{\contact}{%
        {\normalsize \@city/\@country  \cps \@mobile \\ \@mail
%        \\%									uncomment for linkedin + github link in contact card
%        \linkedinview \cps \githubview \\% 	uncomment for linkedin + github link in contact card
    	} % 
}

% Covverletterview

\newcommand\coverletter[1]{ 
\\  \coverlettersubview 
\section{} \vspace{1ex} 
\textbf{ Dear \@contactperson, \\[0.1cm]}
  #1
}

\newcommand\coverlettersubview{
\begin{tabular}{>{\scshape \bfseries \color{\@themecolor}}l  >{\small }l}
Company: & \@companyname \\
Position: & \@claimedposition \\
\end{tabular}
}


% Helper commands

\newcommand\ruleafter[1]{#1~{\color{black!60!\@themecolor}\hrulefill\vspace{0.4cm}}} % a trick to put the line with <before> parameter in \titleformat

%colorfulpipeseperator

\newcommand{\newtextbar}[1][1.4]{\scalebox{#1}[1]{\textbar}}
\newcommand{\cps}{{\color{\@themecolor} \quad\newtextbar\quad}}
\newcommand{\cpshalf}{{\color{\@themecolor} \hspace{0.2em}\newtextbar\hspace{0.2em}}}
\newcommand\cpsc[1]{{\color{\@themecolor} \hspace{#1cm}\newtextbar\hspace{#1cm}}}

\newcommand{\coloredbullet}{{\color{\@themecolor} \textbullet}}

% Edit section styles

\titleformat{\section}      % Customise the \section command 
  {\Large\bfseries\scshape\raggedright\color{\@themecolor}} % Make the \section headers large (\Large),
                               % small capitals (\scshape) and left aligned (\raggedright)
  {}{0em}                      % Can be used to give a prefix to all sections, like 'Section ...'
  {\ruleafter}                 % Can be used to insert code before the heading

\titlespacing*{\section}{-1pt}{0pt}{0pt}

% Textview commands

\newcommand{\addblocktext}[2]{%
	\section{#1} 
	\hspace{7.7em}\begin{minipage}{0.75\linewidth}\sloppy\small{#2} \end{minipage} \vspace{0.15cm}
}

% usage: \education{Name}{Attendance time}{brief explanation}
\newcommand{\education}[3]{%
	\begin{normalsize} \mbox { \hspace{7em} \scshape \textbf{#1} } \end{normalsize} \hfill \datetext{#2}\\[0.01cm] %
	\mbox { \scshape \hspace{7.3em} \small #3} 
}

% usage: \experiences{Name}{Time}{brief explanation}
\newcommand{\experiences}[3]{%
	\begin{normalsize} \mbox { \hspace{7em} \scshape \textbf{#1} } \end{normalsize} \hfill \datetext{#2}\\[0.01cm] %
	\mbox { \scshape \hspace{7.3em} \small #3}%
}

\newcommand{\datetext}[1]{%
{\itshape  \small \mdseries  \color{black!60!\@themecolor} #1 } 
}

\newcommand\createskill[2]{%
	\textsc{\small\textbf{#1}} & \small #2
}


\newcommand{\bigsize}{\fontsize{14pt}{20pt}\selectfont}

% usage: \icon{File Name}{Height in Document}{horizontal space}
\newcommand{\icon}[3]{%
	\begin{minipage}{#3cm}\includegraphics[height=#2cm]{#1}\end{minipage}
}

% usage: \Hobby{Hobby name}{File Name}{Height in Document}{horizontal space}
\newcommand{\Hobby}[4]{%
		\;\icon{#2}{#3}{#4}\mbox{\small #1}
}

\newcommand{\achievement}[1]{%
	\begin{minipage}{\linewidth}\hspace{7.5em} \small #1 \end{minipage} \\[0.1cm] %
}

\newcommand\createbullets[1]{%
    \renewcommand{\labelitemi}{\coloredbullet}
  \begin{itemize}
    \makeatletter
    \@for\thisitem:=#1\do{\itemwithtext{\thisitem}}
    \makeatother
  \end{itemize}
}

\newcommand\createfootnote{%
  \renewcommand{\footnotesize}{\fontsize{8pt}{12pt}\selectfont}
    \renewcommand\footnoterule{\rule{0.3\linewidth}{0.5pt}}
    \let\thefootnote\relax\footnote{\quad \@city\cpshalf\today}}