%%
%% Customizacoes do abnTeX2 (http://abnTeX2.googlecode.com) para o 
%% Instituto de Ciencias Matematicas e de Computacao, Universidade 
%% de Sao Paulo
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Humberto Lidio Antonelli, 
%% Contact: humbertoantonelli@usp.br
%%
%% Further information about abnTeX2 are available on 
%% http://abntex2.googlecode.com/
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{packages/icmc}[2021/08/11 v1.4.1 Classe ICMC baseado em abnTeX2 - Teses e Dissertacoes dos Programas de Pos-graduacao do Instituto de Ciencias Matematicas e de Computacao]
\PassOptionsToPackage{main=english,english}{babel}
\RequirePackage{xifthen}
\RequirePackage{ifxetex}        % Verifica se a compilacao ocorre por xetex
\RequirePackage{ifluatex}       % Verifica se a compilacao ocorre por luatex

%================================================================================
% Declaracao de opcoes
%================================================================================
% Opcoes:
% 	qualificacao:   Formata documento para qualificacao
%	doutorado:      Formata documento para tese de doutorado
% 	mestrado:       Formata documento para dissertacao de mestrado
% 	pre-defesa:     Formata documento para versao de defesa (utilizado apenas para versao completa)
%   pro-defesa:     Formata documento para versao final (utilizado apenas para versao completa)
%   impressao:      Formata documento para versao de impressao
% -------------------------------------------------------------------------------

\DeclareOption*{%
    \PackageWarning{icmc}{Unknown option ‘\CurrentOption’}%
}

\newboolean{opt-qualificacao}
\setboolean{opt-qualificacao}{false}
\DeclareOption{qualificacao}{
    \setboolean{opt-qualificacao}{true}
}

\newboolean{opt-doutorado}
\DeclareOption{doutorado}{
    \setboolean{opt-doutorado}{true}
}
\DeclareOption{mestrado}{
    \setboolean{opt-doutorado}{false}
}
\ExecuteOptions{doutorado}

\newboolean{opt-pre-defesa}
\DeclareOption{pre-defesa}{
    \setboolean{opt-pre-defesa}{true}
}
\DeclareOption{pos-defesa}{
    \setboolean{opt-pre-defesa}{false}
}
\ExecuteOptions{pos-defesa}

\newboolean{opt-impressao}
\setboolean{opt-impressao}{false}
\newcommand{\colorlinks}{true}
\DeclareOption{impressao}{
    \setboolean{opt-impressao}{true}
    \renewcommand{\colorlinks}{false}
}

% Repassa demais opcoes a abntex	
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{abntex2}%
}

\ProcessOptions\relax


%================================================================================
% Heranca da classe `abntex2' e inclusao de pacotes e arquivos necessarios
%================================================================================
\LoadClass[% -- opcoes da classe memoir --
	12pt,				% tamanho da fonte
	openright,			% capitulos comecam em pagina impar (insere pagina vazia caso preciso)
	twoside,			% para impressao em verso e anverso. Oposto a oneside
	a4paper,			% tamanho do papel. 
	% chapter=TITLE		% titulos de capitulos convertidos em letras maiusculas
	]{abntex2}
	

%================================================================================
% Pacotes fundamentais 
%================================================================================
\RequirePackage{morewrites}     % Resolve o erro “No room for a new \write”
\RequirePackage{cmap}			% Mapear caracteres especiais no PDF
\RequirePackage{lmodern}		% Usa a fonte Latin Modern.
\RequirePackage{lastpage}		% Usado pela Ficha catalografica
\RequirePackage{indentfirst}	% Indenta o primeiro paragrafo de cada secao.
\RequirePackage{color, xcolor}  % Controle das cores
\RequirePackage{colortbl}       % Controle das cores das celulas da tabela(utilizado no titulo)
\RequirePackage{graphicx}		% Inclusao de graficos
\RequirePackage{caption}        % Pacote para definicao dos captions
\RequirePackage{subcaption}     % Pacote para definicao dos subcaptions(ambientes de subfigures)
% \RequirePackage{microtype} 		% para melhorias de justificacao
\RequirePackage{pdfpages}       % Inclusao de arquivos PDF
\RequirePackage{hyphenat}       % Pacote para retirar a hifenizacao do preambulo
\RequirePackage{xstring}        % Pacate para manipulacao de Strings
\RequirePackage{etoolbox}       % Pacote utilizado para armazenamento de resumos
\RequirePackage{amsthm, amsfonts, amsmath, amssymb} % Pacote para a definicao dos ambientes matematicos
\RequirePackage{libertineRoman}
\RequirePackage[libertine]{newtxmath}
\RequirePackage{nomencl}        % Pacote para criacao da Lista de Siglas
\RequirePackage[noredefwarn,translate=babel,nonumberlist,style=list,toc]{glossaries}	 % Pacote para gerar o glossario
\RequirePackage{float}          % Pacote para criacao de novos ambientes
\RequirePackage{environ}        % Pacote para definicao de ambientes
\RequirePackage[absolute]{textpos} % Pacote para posicionamento do texto
\RequirePackage{eso-pic}        % Pacote para incluir imagem de fundo
\RequirePackage{adjustbox}      % Pacote para ajuste do tamanho do nome do autor na capa
\RequirePackage{translations}
\RequirePackage{cleveref}


%================================================================================
% Comando para configuracao do tipo de trabalho
%================================================================================

\makeatletter
\def\@trnslt@current@language{english}
\makeatother

\providecommand*{\tipoexemplar}{}
\providecommand*{\degree}{}
\providecommand*{\tipodocurso}{}
\providecommand*{\exam}{}
\providecommand*{\arealabel}{}

% Configuracao do texto do preambulo
\DeclareTranslation{English}{icmc-exam}{ in accordance with the requirements of the \imprimirprograma, for the}
\DeclareTranslation{Portuguese}{icmc-exam}{ como parte dos requisitos para obten{\c c}{\~a}o do t{\'i}tulo de}

% Comando para definir o genero do autor (M = Masculino / F = Feminino)
\providecommand{\imprimirgenero}{M}
\newcommand{\genero}[1]{
    \renewcommand{\imprimirgenero}{#1}
    \IfEq{\imprimirgenero}{M}{}{
        \IfEq{\imprimirgenero}{F}{}{
            \PackageError{ICMC}{Ilegal parameter of genero}{
                Unknow gender "#1"!
                Please, use "M" or "F". The option must be in uppercase.
            }
            \stop
        }
    }
}

% Configuracao da situacao do trabalho entregue
\ifthenelse{\boolean{opt-pre-defesa}}{
    \DeclareTranslation{English}{icmc-tipoexemplar}{EXAMINATION BOARD PRESENTATION COPY}
    \DeclareTranslation{Portuguese}{icmc-tipoexemplar}{EXEMPLAR DE DEFESA}
}{
    \DeclareTranslation{English}{icmc-tipoexemplar}{FINAL VERSION}
    \DeclareTranslation{Portuguese}{icmc-tipoexemplar}{VERS{\~A}O REVISADA}
}
\renewcommand{\exam}{\GetTranslation{icmc-exam}}
\renewcommand{\tipoexemplar}{\GetTranslation{icmc-tipoexemplar}}

% Configuracao do tipo de trabalho para DOUTORADO ou MESTRADO
\ifthenelse{\boolean{opt-doutorado}}{
    \DeclareTranslation{English}{icmc-degree}{degree of Doctor}
    \DeclareTranslation{English}{icmc-tipodocurso}{Doctorate Candidate}
    \DeclareTranslation{English}{icmc-tipotrabalho}{Thesis}
    \ifthenelse{\equal{\imprimirgenero}{M}}{
        \DeclareTranslation{Portuguese}{icmc-degree}{Doutor}
    }{
        \DeclareTranslation{Portuguese}{icmc-degree}{Doutora}
    }
    \DeclareTranslation{Portuguese}{icmc-tipodocurso}{Doutorado}
    \DeclareTranslation{Portuguese}{icmc-tipotrabalho}{Tese}
}{
    \DeclareTranslation{English}{icmc-degree}{degree of Master}
    \DeclareTranslation{English}{icmc-tipodocurso}{Master student}
    \DeclareTranslation{English}{icmc-tipotrabalho}{Dissertation}
    \ifthenelse{\equal{\imprimirgenero}{M}}{
        \DeclareTranslation{Portuguese}{icmc-degree}{Mestre}
    }{
        \DeclareTranslation{Portuguese}{icmc-degree}{Mestra}
    }
    \DeclareTranslation{Portuguese}{icmc-tipodocurso}{Mestrado}
    \DeclareTranslation{Portuguese}{icmc-tipotrabalho}{Disserta{\c c}{\~a}o}
}
\renewcommand{\degree}{\GetTranslation{icmc-degree}}
\renewcommand{\tipodocurso}{\GetTranslation{icmc-tipodocurso}}
\tipotrabalho{\GetTranslation{icmc-tipotrabalho}}

% Configuracao do tipo de trabalho como QUALIFICACAO de DOUTORADO ou MESTRADO
\ifthenelse{\boolean{opt-qualificacao}}{
    \DeclareTranslation{English}{icmc-exam}{ as part of the qualifying exam requisites of the \imprimirprograma, for the}
    \DeclareTranslation{English}{icmc-tipotrabalho}{Monograph}
    \DeclareTranslation{English}{icmc-tipoexemplar}{}
    \DeclareTranslation{Portuguese}{icmc-exam}{ para o Exame de Qualifica{\c c}{\~a}o, como parte dos requisitos para obten{\c c}{\~a}o do t{\'i}tulo de}
    \DeclareTranslation{Portuguese}{icmc-tipotrabalho}{Monografia}
    \DeclareTranslation{Portuguese}{icmc-tipoexemplar}{}
    \renewcommand{\exam}{\GetTranslation{icmc-exam}}
    \tipotrabalho{\GetTranslation{icmc-tipotrabalho}}
    \renewcommand{\tipoexemplar}{\GetTranslation{icmc-tipoexemplar}}
}{}

% Configuracao do texto impresso no Preambulo
\DeclareTranslation{English}{icmc-preambulo-prefix}{submitted to the}
\DeclareTranslation{Portuguese}{icmc-preambulo-prefix}{apresentada ao}
\DeclareTranslation{English}{icmc-preambulo-sep}{~--~}
\DeclareTranslation{Portuguese}{icmc-preambulo-sep}{,}
\DeclareTranslation{English}{icmc-arealabel}{Concentration Area}
\DeclareTranslation{Portuguese}{icmc-arealabel}{{\'A}rea de Concentra{\c c}{\~a}o}

\renewcommand{\imprimirpreambulo}{\nohyphens{\imprimirtipotrabalho~\GetTranslation{icmc-preambulo-prefix}~\imprimirinstituicao\GetTranslation{icmc-preambulo-sep}\exam~\degree~\imprimirespecialidade. \textit{\tipoexemplar}}}
\renewcommand{\arealabel}{\GetTranslation{icmc-arealabel}}


%================================================================================
% Comando auxiliares
%================================================================================

% Comando para marcar texto para revisao
\newcommand{\rev}[1]{\textcolor{red}{[#1]}}

% Legendas utilizadas em Figuras / Tabelas / Etc.
\DeclareTranslation{Portuguese}{icmc-legend-source}{Fonte}
\DeclareTranslation{English}{icmc-legend-source}{Source}
\DeclareTranslation{Portuguese}{icmc-legend-author}{Elaborada pelo autor.}
\DeclareTranslation{English}{icmc-legend-author}{Elaborated by the author.}
\DeclareTranslation{Portuguese}{icmc-legend-adapted}{Adaptada de}
\DeclareTranslation{English}{icmc-legend-adapted}{Adapted from}
\DeclareTranslation{Portuguese}{icmc-legend-research}{Dados da pesquisa.}
\DeclareTranslation{English}{icmc-legend-research}{Research data.}

\newcommand{\fautor}{\legend{\GetTranslation{icmc-legend-source}: \GetTranslation{icmc-legend-author}}}
\newcommand{\fadaptada}[2][]{\legend{\GetTranslation{icmc-legend-source}: \GetTranslation{icmc-legend-adapted}~\citeonline[#1]{#2}.}}
\newcommand{\fdireta}[2][]{\legend{\GetTranslation{icmc-legend-source}: \citeonline[#1]{#2}.}}
\newcommand{\fdadospesquisa}{\legend{\GetTranslation{icmc-legend-source}: \GetTranslation{icmc-legend-research}}}

% Automatiza o processo de aspas
\newcommand{\aspas}[1]{``{#1}''}

% Palavras-chave do resumo
\newcommand{\palavraschave}{}


%================================================================================
% Pacote para criacao da lista de siglas e abreviaturas
%================================================================================

% Configuracao do pacote nomencl
% Tamanho da Label da sigla
\setlength{\nomlabelwidth}{0.15\hsize} 
% Separa as abreviaturas de suas definicoes com pontos (....)
\renewcommand{\nomlabel}[1]{#1 \hfill}
\setlength{\nomitemsep}{-.05in} 
% Comando necessario para a criacao da lista de abreviaturas
\makenomenclature
% Traduz o titulo da lista de abreviaturas
% \renewcommand{\nomname}{\listadesimbolosname}

% Comando para criacao de abreviaturas e siglas
\def\sigla{\@ifstar\@sigla\@@sigla}
% Apenas faz o registro na tabela de siglas
\def\@sigla#1#2{\nomenclature{#1}{#2}}          % \sigla*{}{} 
% Faz o registro na tabela de siglas e insere os dados no corpo do documento
\def\@@sigla#1#2{#2 (#1)\nomenclature{#1}{#2}}  % \sigla{}{}


%================================================================================
% Pacote para criacao do GLOSSARIO
%================================================================================
% Gera o indice do Glossario
\makeglossaries
% Traduz o nome do glossario
\DeclareTranslation{Portuguese}{icmc-glossaryname}{Gloss\'ario}
\DeclareTranslation{English}{icmc-glossaryname}{Glossary}
\renewcommand{\glossaryname}{\GetTranslation{icmc-glossaryname}}

% Contador de definicoes do Glossario
\newcounter{count_glossario}
% Comando para simplificar a definicao de palavras no glossario
\newcommand{\newword}[2]{%
    \stepcounter{count_glossario}% Incrementa o contador do glossario
    \newglossaryentry{Def.\arabic{count_glossario}}{%
        name={#1:},%
        description={#2},%
    }%
}

% Alteracao no formato do nome do glossario que aparece no sumario
\ifthenelse{\boolean{ABNTEXupperchapter}}{
    \renewcommand{\glssettoctitle}[1]{%
        \renewcommand{\glossarytoctitle}{%
            \texorpdfstring{\MakeTextUppercase{\csname @glotype@#1@title\endcsname}}{\csname @glotype@#1@title\endcsname}
        }
    }
}{}



%================================================================================
% Definicao/Alteracao de comandos uitlizados
%================================================================================

% Permite comandos com @ no nome
\makeatletter

% Comando para selecionar o idioma principal do texto
\providecommand{\imprimiridioma}{EN}
\newcommand{\idioma}[1]{
    \renewcommand{\imprimiridioma}{#1}
    \IfEq{\imprimiridioma}{EN}{}{
        \IfEq{\imprimiridioma}{PT}{}{
            \PackageError{ICMC}{Ilegal parameter of idioma}{
                Unknow language "#1"!
                Please, use "PT" to portuguese language or "EN" to english language. The option must be in uppercase.
            }
            \stop
        }
    }
}
% Checagem dos dialetos da lingua portuguesa
\newcommand*{\IfLangPortuguese}{%
  \iflanguage{brazil}\@firstoftwo\@secondoftwo%
}

% Comando para definir o titulo em portugues
\providecommand{\imprimirtituloPT}{}
\newcommand{\tituloPT}[1]{\renewcommand{\imprimirtituloPT}{#1}}%

% Comando para definir o titulo em ingles
\providecommand{\imprimirtituloEN}{}
\newcommand{\tituloEN}[1]{\renewcommand{\imprimirtituloEN}{#1}}%

\providecommand{\imprimirmaintitle}{}
\IfLangPortuguese{\renewcommand{\imprimirmaintitle}{\imprimirtituloPT}}{\renewcommand{\imprimirmaintitle}{\imprimirtituloEN}}

% Hook into language change to update titulo
% \apptocmd{\selectlanguage}{%
%   \iflanguage{english}{\titulo{\imprimirtituloEN}}{}%
%   \iflanguage{brazil}{\titulo{\imprimirtituloPT}}{}%
% }{}{}

% Comando para definicao do nome e sobrenome do autor
\renewcommand\autor[2][Nome para Referencia]{
    
    \StrCount{#2}{\space}[\nbmatch]%
    \StrCut[\nbmatch]{#2}{\space}\strfirstautor\strsecondautor

    \global\def\@authname{\strfirstautor}
    \global\def\@authsurn{\strsecondautor}
    \def\ABNTautordata{\@authname~\@authsurn}
    \renewcommand{\imprimirautor}{\@authname~\@authsurn}
    \def\ABNTautorreferencia{#1}
    \def\ABNTautordatabib{\@authsurn, \@authname}
    \global\def\@author{\@authname~\@authsurn}
}

% Retira os dois pontos (:) que vem por padrao da classe Abntex2
\DeclareTranslation{Portuguese}{icmc-orientadorname}{Orientador}
\DeclareTranslation{English}{icmc-orientadorname}{Advisor}
\DeclareTranslation{Portuguese}{icmc-coorientadorname}{Coorientador}
\DeclareTranslation{English}{icmc-coorientadorname}{Co-advisor}

\renewcommand{\orientadorname}{\GetTranslation{icmc-orientadorname}}
\renewcommand{\coorientadorname}{\GetTranslation{icmc-coorientadorname}}

% Redefinicao do comando de orientador
\renewcommand{\orientador}[3][\orientadorname]{

    \StrCount{#3}{\space}[\nbmatch]%
    \StrCut[\nbmatch]{#3}{\space}\strfirstorientador\strsecondorientador

    \DeclareTranslation{Portuguese}{icmc-orientador-rotulo}{#1}
    \DeclareTranslation{English}{icmc-orientador-rotulo}{\GetTranslation{icmc-orientadorname}}
    \renewcommand{\imprimirorientadorRotulo}{\GetTranslation{icmc-orientador-rotulo}}
    \newcommand{\titulacaoorientador}{#2}
    \def\ABNTorientadordatabib{\strsecondorientador, \strfirstorientador}
    \renewcommand{\imprimirorientador}{\strfirstorientador~\strsecondorientador}
}

% Redefinicao do comando de co-orientador
\renewcommand{\coorientador}[3][\coorientadorname]{

    \StrCount{#3}{\space}[\nbmatch]%
    \StrCut[\nbmatch]{#3}{\space}\strfirstcoorientador\strsecondcoorientador

    \DeclareTranslation{Portuguese}{icmc-coorientador-rotulo}{#1}
    \DeclareTranslation{English}{icmc-coorientador-rotulo}{\GetTranslation{icmc-coorientadorname}}
    \renewcommand{\imprimircoorientadorRotulo}{\GetTranslation{icmc-coorientador-rotulo}}
    \newcommand{\titulacaocoorientador}{#2}
    \def\ABNTcoorientadordatabib{\strsecondcoorientador, \strfirstcoorientador}
    \renewcommand{\imprimircoorientador}{\strfirstcoorientador~\strsecondcoorientador}
}

% Comando para definicao da area de concentracao
\providecommand{\imprimirarea}{}
\newcommand{\area}[1]{\renewcommand{\imprimirarea}{#1}}

% Comando para definicao da especialidade do Titulo
\providecommand{\imprimirespecialidade}{}
\newcommand{\especialidade}[1]{\renewcommand{\imprimirespecialidade}{#1}}

% Comando para definicao do nome do Programa
\providecommand{\imprimirprograma}{}
\providecommand{\imprimirsiglaprograma}{}
\newcommand{\programa}[2]{
    \renewcommand{\imprimirsiglaprograma}{#1}
    \renewcommand{\imprimirprograma}{#2}
}

% Comando para definicao da Universidade
\providecommand{\imprimiruniversidade}{}
\newcommand{\universidade}[1]{\renewcommand{\imprimiruniversidade}{#1}}

% Camando para definicao do programa de Pos-Graduacao, Especialidade do Titulo e Instituicao
\newcommand{\curso}[1]{

% Default institution
\DeclareTranslation{Portuguese}{icmc-universidade}{USP}
\DeclareTranslation{English}{icmc-universidade}{USP}
\DeclareTranslation{Portuguese}{icmc-instituicao}{Instituto de Ci{\^e}ncias Matem{\'a}ticas e de Computa{\c c}{\~a}o -- ICMC-USP}
\DeclareTranslation{English}{icmc-instituicao}{Instituto de Ci{\^e}ncias Matem{\'a}ticas e de Computa{\c c}{\~a}o -- ICMC-USP}

\universidade{\GetTranslation{icmc-universidade}}
\instituicao{\GetTranslation{icmc-instituicao}}

% CCMC ==========================================================================
    \ifthenelse{\equal{#1}{CCMC}}{
        \DeclareTranslation{Portuguese}{icmc-area}{Ci{\^e}ncias de Computa{\c c}{\~a}o e Matem{\'a}tica Computacional}
        \DeclareTranslation{English}{icmc-area}{Computer Science and Computational Mathematics}
        \DeclareTranslation{Portuguese}{icmc-programa-long}{Programa de P{\'o}s-Gradua{\c c}{\~a}o em Ci{\^e}ncias de Computa{\c c}{\~a}o e Matem{\'a}tica Computacional}
        \DeclareTranslation{English}{icmc-programa-long}{Computer and Mathematical Sciences Graduate Program}
        \DeclareTranslation{Portuguese}{icmc-especialidade}{em Ci{\^e}ncias -- Ci{\^e}ncias de Computa{\c c}{\~a}o e Matem{\'a}tica Computacional}
        \DeclareTranslation{English}{icmc-especialidade}{in Science}

        \area{\GetTranslation{icmc-area}}
        \programa{PPG-CCMC}{\GetTranslation{icmc-programa-long}}
        \especialidade{\GetTranslation{icmc-especialidade}}
    }{
% MAT ===========================================================================
        \ifthenelse{\equal{#1}{MAT}}{
            \DeclareTranslation{Portuguese}{icmc-area}{Matem{\'a}tica}
            \DeclareTranslation{English}{icmc-area}{Mathematics}
            \DeclareTranslation{Portuguese}{icmc-programa-long}{Programa de P{\'o}s-Gradua{\c c}{\~a}o em Matem{\'a}tica}
            \DeclareTranslation{English}{icmc-programa-long}{Mathematics Graduate Program}
            \DeclareTranslation{Portuguese}{icmc-especialidade}{em Ci{\^e}ncias -- Matem{\'a}tica}
            \DeclareTranslation{English}{icmc-especialidade}{in Science}

            \area{\GetTranslation{icmc-area}}
            \programa{PPG-Mat}{\GetTranslation{icmc-programa-long}}
            \especialidade{\GetTranslation{icmc-especialidade}}
        }{
% PIPGES ========================================================================
            \ifthenelse{\equal{#1}{PIPGES}}{
                \DeclareTranslation{Portuguese}{icmc-instituicao}{Instituto de Ci{\^e}ncias Matem{\'a}ticas e de Computa{\c c}{\~a}o -- ICMC-USP e ao Departamento de Estat{\'i}stica -- DEs-UFSCar}
                \DeclareTranslation{English}{icmc-instituicao}{Institute of Mathematics and Computer Science -- ICMC-USP and to the Department of Statistics -- DEs-UFSCar}
                \DeclareTranslation{Portuguese}{icmc-area}{Estat{\'i}stica}
                \DeclareTranslation{English}{icmc-area}{Statistics}
                \DeclareTranslation{Portuguese}{icmc-programa-long}{Programa Interinstitucional de P{\'o}s-Gradua{\c c}{\~a}o em Estat{\'i}stica}
                \DeclareTranslation{English}{icmc-programa-long}{Statistics Interagency Graduate Program}
                \DeclareTranslation{Portuguese}{icmc-especialidade}{em Estat{\'i}stica -- Programa Interinstitucional de P{\'o}s-Gradua{\c c}{\~a}o em Estat{\'i}stica}
                \DeclareTranslation{English}{icmc-especialidade}{in Statistics}

                \instituicao{\GetTranslation{icmc-instituicao}}
                \area{\GetTranslation{icmc-area}}
                \programa{PIPGEs}{\GetTranslation{icmc-programa-long}}
                \especialidade{\GetTranslation{icmc-especialidade}}
            }{
% PROFMAT =======================================================================
                \ifthenelse{\equal{#1}{PROFMAT}}{
                    \DeclareTranslation{Portuguese}{icmc-area}{Mestrado Profissional em Matem{\'a}tica em Rede Nacional}
                    \DeclareTranslation{English}{icmc-area}{Professional Master Degree Program in Mathematics in National Network}
                    \DeclareTranslation{Portuguese}{icmc-programa-long}{Programa de Mestrado Profissional em Matem{\'a}tica em Rede Nacional}
                    \DeclareTranslation{English}{icmc-programa-long}{Professional Master's Program in Mathematics in National Network}
                    \DeclareTranslation{Portuguese}{icmc-especialidade}{em Ci{\^e}ncias -- Mestrado Profissional em Matem{\'a}tica em Rede Nacional}
                    \DeclareTranslation{English}{icmc-especialidade}{in Science}

                    \area{\GetTranslation{icmc-area}}
                    \programa{PROFMAT}{\GetTranslation{icmc-programa-long}}
                    \especialidade{\GetTranslation{icmc-especialidade}}
                }{
% MECAI =========================================================================
                    \ifthenelse{\equal{#1}{MECAI}}{
                        \DeclareTranslation{Portuguese}{icmc-area}{Matem{\'a}tica, Estat{\'i}stica e Computa{\c c}{\~a}o}
                        \DeclareTranslation{English}{icmc-area}{Mathematics, Statistics and Computing}
                        \DeclareTranslation{Portuguese}{icmc-programa-long}{Programa de Mestrado Profissional em Matem{\'a}tica, Estat{\'i}stica e Computa{\c c}{\~a}o Aplicadas {\`a} Ind{\'u}stria}
                        \DeclareTranslation{English}{icmc-programa-long}{Professional Master's Program in Mathematics Statistics and Computing Applied to Industry}
                        \DeclareTranslation{Portuguese}{icmc-especialidade}{-- Mestrado Profissional em Matem{\'a}tica, Estat{\'i}stica e Computa{\c c}{\~a}o Aplicadas {\`a} Ind{\'u}stria}
                        \DeclareTranslation{English}{icmc-especialidade}{in Science}

                        \area{\GetTranslation{icmc-area}}
                        \programa{MECAI}{\GetTranslation{icmc-programa-long}}
                        \especialidade{\GetTranslation{icmc-especialidade}}
                    }{
% Outros ========================================================================
                        \PackageError{ICMC}{Ilegal parameter of curso}{
                            Unknow curso "#1"!
                            Please, use "CCMC", "MAT", "PIPGES", "PROFMAT", or "MECAI". The option must be in upperrcase.
                        }
                        \stop
                    }
                }
            }
        }
    }

}

% Redefinicao do comando \date do Latex
\renewcommand{\date}[3]{%
  \gdef\@day{#1}%
  \gdef\@month{#2}%
  \gdef\@year{#3}%
}

% Define a data
\date{\number\day}{\number\month}{\number\year}

% Redefinicao do comando de data do ABNTex
\renewcommand{\data}[3]{%
    \date{#1}{#2}{#3}%
}

% Nome do Mes
\DeclareTranslation{Portuguese}{icmc-month-01}{Janeiro}
\DeclareTranslation{Portuguese}{icmc-month-02}{Fevereiro}
\DeclareTranslation{Portuguese}{icmc-month-03}{Mar{\c c}o}
\DeclareTranslation{Portuguese}{icmc-month-04}{Abril}
\DeclareTranslation{Portuguese}{icmc-month-05}{Maio}
\DeclareTranslation{Portuguese}{icmc-month-06}{Junho}
\DeclareTranslation{Portuguese}{icmc-month-07}{Julho}
\DeclareTranslation{Portuguese}{icmc-month-08}{Agosto}
\DeclareTranslation{Portuguese}{icmc-month-09}{Setembro}
\DeclareTranslation{Portuguese}{icmc-month-10}{Outubro}
\DeclareTranslation{Portuguese}{icmc-month-11}{Novembro}
\DeclareTranslation{Portuguese}{icmc-month-12}{Dezembro}

\DeclareTranslation{English}{icmc-month-01}{January}
\DeclareTranslation{English}{icmc-month-02}{February}
\DeclareTranslation{English}{icmc-month-03}{March}
\DeclareTranslation{English}{icmc-month-04}{April}
\DeclareTranslation{English}{icmc-month-05}{May}
\DeclareTranslation{English}{icmc-month-06}{June}
\DeclareTranslation{English}{icmc-month-07}{July}
\DeclareTranslation{English}{icmc-month-08}{August}
\DeclareTranslation{English}{icmc-month-09}{September}
\DeclareTranslation{English}{icmc-month-10}{October}
\DeclareTranslation{English}{icmc-month-11}{November}
\DeclareTranslation{English}{icmc-month-12}{December}

\providecommand*{\Monthname}{}
\renewcommand\Monthname[1][EMPTY]{%
  \edef\translationkey{icmc-month-#1}%
  \expandafter\GetTranslation\expandafter{\translationkey}%
}

% Opcao para exibir a lista de figuras
\newcommand{\incluilistadefiguras}{
  \gdef\@incluilistadefiguras{true}
}

% Opcao para exibir a lista de tabelas
\newcommand{\incluilistadetabelas}{
  \gdef\@incluilistadetabelas{true}
}

% Opcao para exibir a lista de siglas
\newcommand{\incluilistadesiglas}{
  \gdef\@incluilistadesiglas{true}
}

% Opcao para exibir a lista de simbolos
\newcommand{\incluilistadesimbolos}{
  \gdef\@incluilistadesimbolos{true}
}

% Opcao para exibir a lista de quadros
\newcommand{\incluilistadequadros}{
  \gdef\@incluilistadequadros{true}
}

% Opcao para exibir a lista de algoritmos
\newcommand{\incluilistadealgoritmos}{
  \gdef\@incluilistadealgoritmos{true}
}

% Opcao para exibir a lista de codigos
\newcommand{\incluilistadecodigos}{
  \gdef\@incluilistadecodigos{true}
}

% Comando para inclusao da ficha catalografica
\newboolean{opt-fichacatalografica}
\setboolean{opt-fichacatalografica}{false}
\newcommand{\incluifichacatalografica}[1]{
    % Incluir um arquivo externo como ficha catalografica
    \setboolean{opt-fichacatalografica}{true}%
    \gdef\@arquivofichacatalografica{#1}%
}

%================================================================================
% Criacao dos Ambientes Flutuantes para Quadros
%================================================================================

\DeclareTranslation{Portuguese}{icmc-listquadroname}{Lista de quadros}
\DeclareTranslation{English}{icmc-listquadroname}{List of charts}
\DeclareTranslation{Portuguese}{icmc-quadroname}{Quadro}
\DeclareTranslation{English}{icmc-quadroname}{Chart}

\newcommand{\listquadroname}{\GetTranslation{icmc-listquadroname}}
\newcommand{\quadroname}{\GetTranslation{icmc-quadroname}}
\newcommand{\quadrorefname}{\GetTranslation{icmc-quadroname}}
\newcommand{\chartautorefname}{\GetTranslation{icmc-quadroname}}

\newfloat{quadro}{htbp}{loq}[chapter]
\floatname{quadro}{\quadroname}
\floatstyle{plaintop}
\restylefloat{quadro}
\newlistof{listofquadros}{loq}{\listquadroname}
\newlistentry{quadro}{loq}{0}
\renewcommand{\thequadro}{\thechapter.\@arabic\c@quadro}
\setfloatadjustment{quadro}{\centering}

\renewcommand{\cftquadroname}{\quadroname\space}
\renewcommand*{\cftquadroaftersnum}{\hfill\textendash\hfill}

%================================================================================
% Comando para configurar os captions no documento
%================================================================================
\renewcommand{\ABNTEXfontereduzida}{\small} % Fonte reduzida para 11pt, conforme recomendacao da USP
\DeclareCaptionFont{ABNTEXfontereduzida}{\ABNTEXfontereduzida}
\captionsetup{position=above, labelfont=ABNTEXfontereduzida, font=ABNTEXfontereduzida}


%================================================================================
% Dedicatoria
%================================================================================

% Comando para definicao da dedicatoria
\def\textodedicatoria{\@ifstar\@textodedicatoria\@@textodedicatoria}
% Inclui texto de um arquivo como dedicatoria
\def\@textodedicatoria#1{\gdef\@dedicatoria{\input{#1}}} % \textodedicatoria*{}{} 
% Inclui o texto como dedicatoria
\def\@@textodedicatoria#1{\gdef\@dedicatoria{#1}}       % \textodedicatoria{}{}

% Criacao da dedicatoria
\newcommand{\inserededicatoria}{
  \@dedicatoria
    % \@ifundefined{@dedicatoria}{}{
    %   \begin{dedicatoria}
    %     \vspace*{\fill}
    %     \centering
    %     \noindent
    %     \textit{\@dedicatoria}
    %     \vspace*{\fill}
    %   \end{dedicatoria}
    % }
}


%================================================================================
% Agradecimentos
%================================================================================

% Comando para definicao dos agradecimentos
\def\textoagradecimentos{\@ifstar\@textoagradecimentos\@@textoagradecimentos}
% Inclui texto de um arquivo como agradecimentos
\def\@textoagradecimentos#1{\gdef\@agradecimentos{\input{#1}}} % \textoagradecimentos*{}{}
% Inclui o texto como agradecimentos
\def\@@textoagradecimentos#1{\gdef\@agradecimentos{#1}} % \textoagradecimentos{}{}

% Criacao dos agradecimentos
\newcommand{\insereagradecimentos}
{
  \@ifundefined{@agradecimentos}{}{
    \begin{agradecimentos}
      \@agradecimentos
    \end{agradecimentos}
  }
}


%================================================================================
% Epigrafe
%================================================================================

% Comando para definicao da epigafe
\def\textoepigrafe{\@ifstar\@textoepigrafe\@@textoepigrafe}
% Inclui texto de um arquivo como epigafe
\def\@textoepigrafe#1{\gdef\@epigrafe{\input{#1}}}      % \textoepigrafe*{}{} 
% Inclui o texto como epigafe
\def\@@textoepigrafe#1{\gdef\@epigrafe{#1}}             % \textoepigrafe{}{}
% Criacao da epigafe
\newcommand{\insereepigrafe}
{
  \@epigrafe
  % \@ifundefined{@epigrafe}{}{
  %       \begin{epigrafe}
  %     \vspace*{\fill}
  %         \begin{flushright}
  %       	\textit{\@epigrafe}
  %         \end{flushright}
  %   \end{epigrafe}	 
    
  % }
}


%================================================================================
% Lista de Simbolos
%================================================================================

% Comando para inserir simbolos na lista de simbolos
\newcommand{\simbolo}[2]{
  \addcontentsline{los}{simbolo}{\ensuremath{#1} --- #2}%
}

% Apresentacao dos simbolos na lista de simbolos
\newcommand\l@simbolo[2]{\par #1}

% Criacao da lista de simbolos
\newcommand{\inserelistadesimbolos}
{
  \@ifundefined{@incluilistadesimbolos}{}{
     \pretextualchapter{\listadesimbolosname}
     {\setlength{\parindent}{0cm}
       \@starttoc{los}
     }
     \cleardoublepage
  }
}


%================================================================================
% Ficha Catalografica
%================================================================================

\newcommand{\inserefichacatalografica}
{
    \@ifundefined{@arquivofichacatalografica}{
        \PackageError{ICMC}{Some file is missing}{
            A ficha catalografica nao foi inserida!
        }
    }{
        \begin{fichacatalografica}
            \includepdf{\@arquivofichacatalografica}
        \end{fichacatalografica}
    }
}


%================================================================================
% Resumo
%================================================================================

% Comando para definicao dos resumos e palavras-chave
\newcounter{numresumo}
\newcommand{\textoresumo}[3][\languagename]{
  \stepcounter{numresumo}%
  \csdef{res-language-\thenumresumo}{#1}
  \csdef{res-text-\thenumresumo}{#2}
  \csdef{res-keywords-\thenumresumo}{#3}
  \IfStrEq{#1}{\languagename}{\renewcommand{\palavraschave}{#3}}{}
}

\newcommand{\xselectlanguage}[1]{\begingroup\edef\x{\endgroup\noexpand\selectlanguage{#1}}\x}
\newenvironment{xotherlanguage}[1]{%
  \begingroup%
  \edef\temp{\endgroup\noexpand\otherlanguage{#1}}%
  \temp%
  \ignorespaces%
}{\endotherlanguage\ignorespacesafterend}

\providecommand{\imprimirlanguage}{brazil}

% Criacao do resumo e palavras chaves no documento
\newcommand{\insereresumo}
{

% Titulos do Resumo
\csdef{res-title-english}{Abstract}
\csdef{res-title-brazil}{Resumo}
\csdef{res-title-french}{R{\'e}sum{\'e}}
\csdef{res-title-spanish}{Resumen}
% Labels: Palavras-chave
\csdef{res-label-keywords-english}{Keywords}
\csdef{res-label-keywords-brazil}{Palavras-chave}
\csdef{res-label-keywords-french}{Mots-cl{\'e}s}
\csdef{res-label-keywords-spanish}{Palabras clave}

% Contador das palavras-chave
\newcounter{count}
\setcounter{count}{0}
  
  \whileboolexpr
    { test {\ifnumcomp{\value{count}}{<}{\thenumresumo}} }%
    {
        \stepcounter{count}
        
        \renewcommand{\imprimirlanguage}{\csuse{res-language-\thecount}}
        
        \if@openright\cleardoublepage\else\clearpage\fi
        \phantomsection
        \begin{resumo}[\csuse{res-title-\csuse{res-language-\thecount}}]
                \begin{SingleSpace}
                    \begin{otherlanguage}{brazil}
                    \IfEndWith{\ABNTautorreferencia}{.}{\MakeUppercase{\ABNTautorreferencia}}{\MakeUppercase{\ABNTautorreferencia}.}~%
                    \textbf{\IfEq{\imprimirlanguage}{english}{\imprimirtituloEN}{\imprimirtituloPT}}. %
                    \@year. \pageref{ultima_pagina_numerada} p. \imprimirtipotrabalho~(\tipodocurso~\imprimirespecialidade) -- Instituto de Ci{\^e}ncias Matem{\'a}ticas e de Computa{\c c}{\~a}o, Universidade de S\~ao Paulo, \imprimirlocal, \@year.
                    \end{otherlanguage}
                \end{SingleSpace}
                
                \vskip 20pt
                \begin{xotherlanguage}{\imprimirlanguage}
                    \csuse{res-text-\thecount}
                    
                    \vspace{\onelineskip}
                    
                    \noindent
                    \textbf{\csuse{res-label-keywords-\csuse{res-language-\thecount}}:}
                    \@tempswafalse
                        \@for\next:=\csuse{res-keywords-\thecount}\do
                        {\if@tempswa,~\else\@tempswatrue\fi\next}.
                \end{xotherlanguage}
        \end{resumo}
    }
}


%================================================================================
% Definicao de comandos a serem inseridos diretamente no inicio do documento
%================================================================================

\newcommand{\inserelistadefiguras}
{
  \@ifundefined{@incluilistadefiguras}{}{
    \pdfbookmark[0]{\listfigurename}{lof}
    \listoffigures*
    \cleardoublepage
  }
}

\newcommand{\inserelistadetabelas}
{
  \@ifundefined{@incluilistadetabelas}{}{
    \pdfbookmark[0]{\listtablename}{lot}
    \listoftables*
    \cleardoublepage
  }
}

\newcommand{\inserelistadesiglas}
{
  \@ifundefined{@incluilistadesiglas}{}{
    \pdfbookmark[0]{\listadesimbolosname}{listadesiglas}
    \printnomenclature
    \cleardoublepage
  }
}

\newcommand{\inserelistadequadros}
{
  \@ifundefined{@incluilistadequadros}{}{
    \pdfbookmark[0]{\listquadroname}{loq}
    \listofquadros*
    \cleardoublepage
  }
}


%================================================================================
% Configuracao da fonte utilizada na capa exigida pelo ICMC
%================================================================================

\newcommand{\@icmcFont}[2][]{\fontsize{#2}{#2}\ifthenelse{\isempty{#1}}{}{\fontspec[Mapping = tex-text, Path = packages/fonts/]{#1}}}

\ifthenelse{\boolean{luatex} \or \boolean{xetex}}{
  % Configuracao da fonte para a compilacao por XeLaTeX ou LuaLaTeX
  \RequirePackage{fontspec}
  \ifxetex
    \RequirePackage{xltxtra}
  \fi
    \newfontfamily{\arial}[
        Ligatures=TeX, % recommended
        Mapping         = tex-text,
        Path            = packages/fonts/,
        BoldFont        = *bd,
        ItalicFont      = *i,
        BoldItalicFont  = *bi]{arial}
    
    \newcommand\@icmcTitulo{\arial\bfseries}
    \newcommand\@icmcAutorCapa{\@icmcFont{14}\arial\bfseries}
    \newcommand\@icmcPrograma{\@icmcFont{11}\arial}
    \newcommand\@icmcTipoTrabalho{\@icmcFont{10}\arial}
    \newcommand\@icmcAutorFolhaRosto{\@icmcFont{13}\arial\bfseries}
    \newcommand\@icmcTituloFolhaRosto{\@icmcFont{17}\arial}
    \newcommand\@icmcOrientador{\@icmcFont{10}\arial}
    \newcommand\@icmcPreambulo{\@icmcFont{10}\arial}
    \newcommand\@icmcLocalData{\@icmcFont{11}\arial\bfseries}
    \newcommand\@icmcCarimbo{\@icmcFont{11}\arial}
    \newcommand\@icmcSVPG{\@icmcFont{8}\arial}
}{
    \newcommand\@icmcTitulo{\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@icmcAutorCapa{\fontsize{14pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@icmcPrograma{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcTipoTrabalho{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcAutorFolhaRosto{\fontsize{13pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@icmcTituloFolhaRosto{\fontsize{17pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcOrientador{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcPreambulo{\fontsize{10pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcLocalData{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{b}{n}}
    \newcommand\@icmcCarimbo{\fontsize{11pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
    \newcommand\@icmcSVPG{\fontsize{8pt}{1em}\selectfont\usefont{T1}{phv}{m}{n}}
}


%================================================================================
% Configuracao do modelo de capa exigido pelo programa do ICMC
%================================================================================

% Configuracao para reduzir tamanho do Titulo da capa automaticamente
\NewEnviron{fittext}{\def\trysize{14pt}\retry}

\def\retry{%
  \expandafter\@firstofone
  {
    \edef\trysize{\the\dimexpr\trysize-0.1pt\relax}%
    \sbox0{%
      \begin{minipage}{144mm}%
        \linespread{1.0}
        \begingroup\edef\x{
          \endgroup\noexpand\fontsize{\trysize}{\trysize}\noexpand\@icmcTitulo%
        }%
        \x\BODY
      \end{minipage}%
    }%
  }%
  \dimen0=\dimexpr\ht0+\dp0\relax
  \ifdim\dimen0>.4\textwidth
    \expandafter\retry
  \else
    \expandafter\parindent0pt\begin{minipage}[c][47mm][c]{144mm}\usebox{0}\end{minipage}
  \fi
}
  
% alterando a capa
\renewcommand{\imprimircapa}{%
  \begin{capa}%

    \begin{textblock*}{144mm}(61mm,65mm)%
      \begin{fittext}
        \centering%
        \textcolor{blue-capa}{
          \nohyphens{\imprimirtituloEN}
        }
      \end{fittext}
    \end{textblock*}%

    \begin{textblock*}{130mm}(81mm,123mm)%
      \noindent
      \begin{minipage}[t][65mm][t]{125mm}
        \begin{otherlanguage}{brazil}
          \begin{SingleSpace}
            \linespread{1.0}%
            \begin{flushleft}
              \nohyphens{%
                \color{blue-capa}%
                \maxsizebox{125mm}{5mm}{\@icmcAutorCapa\imprimirautor}%
                
                \vspace{3mm}%
                
                \ifthenelse{\boolean{opt-qualificacao}}{%
                    \@icmcPrograma Qualifica{\c c}{\~a}o de \tipodocurso~do \imprimirprograma~(\imprimirsiglaprograma)%
                }{%
                    \@icmcPrograma\imprimirtipotrabalho~de \tipodocurso~do \imprimirprograma~(\imprimirsiglaprograma)%
                }%
                
              }
            \end{flushleft}
          \end{SingleSpace}
        \end{otherlanguage}
      \end{minipage}
    \end{textblock*}%

    \AddToShipoutPictureBG*{\includegraphics[height=\paperheight]{packages/capa}}
    ~
    
  \end{capa}
}

% folha de rosto
\newboolean{carimbo-folha-rosto}
\setboolean{carimbo-folha-rosto}{true}
\renewcommand{\folhaderostocontent}{

  \vspace*{-6.2mm}
  \ifthenelse{\boolean{carimbo-folha-rosto}}{
    \makebox[14.9cm][r]{%
      \fbox{
        \parbox{7.2cm}{
          \vspace{0.3cm}
          \makebox[\linewidth][c]{\@icmcSVPG{SERVI{\c C}O DE P{\'O}S-GRADUA{\c C}{\~A}O DO ICMC-USP}}
          
          {
            \@icmcCarimbo
            \vspace{12pt}
            \hspace{2pt} Data de Dep{\'o}sito:
              
            \vspace{9pt}
            \hspace{2pt} Assinatura: \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_
            \vspace{9pt}
          }
        }
      }
    }
  }{\vspace{2.95cm}}
  \begin{center}

    \vspace{0.5cm}

    {\@icmcAutorFolhaRosto\nohyphens{\imprimirautor}}

    \vfill

    \begin{Spacing}{1.5}
      {\@icmcTituloFolhaRosto\nohyphens{\ifcurrentbaselanguage{english}{\imprimirtituloEN}{\imprimirtituloPT}}}
    \end{Spacing}

    \vfill

    \abntex@ifnotempty{\imprimirpreambulo}{%
      \hspace{.43\textwidth}
      \begin{minipage}{8.4cm}
        \begin{Spacing}{0.9}
          {\@icmcPreambulo\imprimirpreambulo}%
        
          \vspace{5pt}
          {\@icmcPreambulo\arealabel: \nohyphens{\imprimirarea}}%
        
          \vspace{5pt}
          {\@icmcOrientador\imprimirorientadorRotulo: \titulacaoorientador{} \nohyphens{\imprimirorientador}}%
          \abntex@ifnotempty{\imprimircoorientador}{%
              \\{\@icmcOrientador\imprimircoorientadorRotulo: \titulacaocoorientador{} \nohyphens{\imprimircoorientador}}
          }%
        \end{Spacing}
      \end{minipage}%
    }%

    \vspace{1cm}

    {
      \@icmcLocalData
      \imprimiruniversidade~-- S{\~a}o Carlos\\ 
      \IfLangPortuguese{\Monthname[\@month] de \@year\\}{\Monthname[\@month]~\@year\\}
    }
    \vspace*{1.2cm}
  \end{center}
  
} %folha de rosto


%================================================================================
% Configuracao dos Estilo dos Capitulo
%================================================================================

\makechapterstyle{icmc}{%
  \renewcommand{\chapterheadstart}{} 
  
  % Secao secundaria (Section) Caixa baixa, Negrito
  \renewcommand*{\cftsectionfont}{\bfseries}
  % Secao terciaria (Subsection) Caixa baixa, Negrito, italico
  % \renewcommand*{\cftsubsectionfont}{\itshape\bfseries}
  % Secao quaternaria (Subsubsection) Caixa baixa, italico
  % \renewcommand*{\cftsubsubsectionfont}{\itshape}
  % Secao quinquenaria (Subsubsubsection) Caixa baixa
  \renewcommand*{\cftparagraphfont}{\normalsize}

  % tamanhos de fontes de chapter e part	
  \setlength{\beforechapskip}{0pt}
  \renewcommand{\ABNTEXchapterfontsize}{\LARGE}
  \renewcommand{\chaptitlefont}{\ABNTEXchapterfont\bfseries\ABNTEXchapterfontsize}
  
  % tamanhos de fontes de section, subsection, subsubsection e subsubsubsection
  \setsecheadstyle{\ABNTEXsectionfont\ABNTEXsectionfontsize\bfseries\ABNTEXsectionupperifneeded}
  \setsubsecheadstyle{\ABNTEXsubsectionfont\ABNTEXsubsectionfontsize\ABNTEXsubsectionupperifneeded}
  \setsubsubsecheadstyle{\ABNTEXsubsubsectionfont\ABNTEXsubsubsectionfontsize\ABNTEXsubsubsectionupperifneeded}
  \setsubsubsubsecheadstyle{\ABNTEXsubsubsubsectionfont\ABNTEXsubsubsubsectionfontsize\ABNTEXsubsubsubsectionupperifneeded}
 
  % impressao do numero do capitulo
  \renewcommand{\chapternamenum}{}
  
  % impressao do nome do capitulo
  \renewcommand{\printchaptername}{}
    
  % impressao do titulo do capitulo
  \def\printchaptertitle##1{%
    
    % \setboolean{ABNTEXupperchapter}{true}
    
    \ifthenelse{\boolean{abntex@innonumchapter}}{
        \vskip 0ex \hrulefill\chaptitlefont\bfseries\ABNTEXchapterupperifneeded{##1}
        \vskip -0.6ex\hfill\rule{.8\textwidth}{0.5pt} 
        \vskip -2.8ex\hfill\rule{.8\textwidth}{2pt}
        \vskip 1.5ex
    
    }{% else
        {\hrulefill
        {\renewcommand{\arraystretch}{1.5} %  1 is the default, change whatever you need
        \begin{tabular}{|c|}
            \rowcolor{black}\color{white}\normalsize\ABNTEXchapterfont
              \ifthenelse{\boolean{abntex@apendiceousecao}}{\MakeTextUppercase{\appendixname}}{\MakeTextUppercase{\chaptername}}  \\ 
            \vspace{-1.5ex}\\ %coloquei para aumentar o espaco entre o titulo e o numero
            \resizebox{!}{1.1cm}{\ABNTEXchapterfont\thechapter}
            \\[2.5ex]
            \hline
        \end{tabular}}} \\
        \vskip 4.3ex \flushright\chaptitlefont\bfseries\ABNTEXchapterupperifneeded{##1} \\
        \vskip -0.6ex\hfill\rule{.8\textwidth}{0.5pt} \\
        \vskip -2.8ex\hfill\rule{.8\textwidth}{2pt} \\
        \vskip 1.5ex
	}    
  }

  % impressao do numero do capitulo     	
  \renewcommand{\printchapternum}{%
    \setboolean{abntex@innonumchapter}{false}%
  }
  \renewcommand{\afterchapternum}{}
  
  % impressao do capitulo nao numerado
  \renewcommand\printchapternonum{%
    \setboolean{abntex@innonumchapter}{true}%
  }
}
\chapterstyle{icmc}


%================================================================================
% Configuracoes diversas
%================================================================================

% informacoes do PDF
\hypersetup{
        unicode=true, % Codificacao dos caracteres especiais no Bookmark
		pdftitle={\@title}, 
		pdfauthor={\@author},
    	pdfsubject={\imprimirpreambulo},
	    pdfcreator={LaTeX with abnTeX2/ICMC-USP (v1.3.6)},
		pdfkeywords={\palavraschave}, 
		colorlinks={\colorlinks},   % colored links
    	linkcolor=blue,          	% color of internal links
    	citecolor=blue,        		% color of links to bibliography
    	filecolor=magenta,      	% color of file links
		urlcolor=blue,
		bookmarksdepth=4
}

% Define as cores basicas utilizadas no documento
\definecolor{blue}{RGB}{41,5,195}
\definecolor{white}{RGB}{255,255,255}
\definecolor{black}{RGB}{0,0,0}
\definecolor{blue-capa}{RGB}{16,62,93}

% Corrige warning gerado pelo uso do comando \uppercase
\ifthenelse{\boolean{ABNTEXsumario-abnt-6027-2012}}{%v
    \renewcommand{\bibsection}{%
        \chapter*{\bibname}
        \bibmark
        \ifnobibintoc\else
        \phantomsection
        \addcontentsline{toc}{chapter}{\texorpdfstring{\MakeTextUppercase{\bibname}}{\bibname}}
        \fi
        \prebibhook
    }
}{}

% Niveis de subsecoes
\setcounter{tocdepth}{4}
\setcounter{secnumdepth}{4}

% Ajusta o espacamento dos paragrafos do resumo
\setlength{\absparsep}{18pt}

% O tamanho do paragrafo e dado por:
\setlength{\parindent}{1.3cm}

% Controle do espacamento entre um paragrafo e outro:
\setlength{\parskip}{0.2cm}  % tente tambem \onelineskip

% Pasta padrao para as imagens
\graphicspath{{images/}}

% Nome do local do instituto
\local{S{\~a}o Carlos -- SP}

% Define o programa de Pos-Graduacao padrao para o template
\curso{CCMC}

% Indice remissivo
\makeindex


%================================================================================
% Configuracoes para definir idioma principal do documento
%================================================================================

\def\HyLang@DeclareLang#1#2#3{%
    \expandafter\HyLang@addto
        \csname extras#1\expandafter\endcsname
        \csname HyLang@#2\endcsname
    \begingroup
      \edef\x{\endgroup
        #3%
      }%
    \x
    \@namedef{HyLang@#1@done}{}%
  \begingroup
    \edef\x##1##2{%
      \noexpand\ifx##2\relax
        \errmessage{No definitions for language #2' found!}%
      \noexpand\fi
      \endgroup
      \noexpand\define@key{Hyp}{#1}[]{%
        \noexpand\@ifundefined{HyLang@#1@done}{%
          \noexpand\HyLang@addto{\noexpand##1}{\noexpand##2}%
          #3%
          \noexpand\@namedef{HyLang@#1@done}{}%
        }{}%
      }%
    }%
  \expandafter\x\csname extras#1\expandafter\endcsname
                \csname HyLang@#2\endcsname
}
% repeat the known language declarations
\HyLang@DeclareLang{english}{english}{}
\HyLang@DeclareLang{brazil}{portuges}{}
\HyLang@DeclareLang{spanish}{spanish}{}

%================================================================================
% Configuracoes ao iniciar documento
%================================================================================
\AtBeginDocument{
    \IfStrEq{\imprimiridioma}{EN}{
        \selectlanguage{english}
    }{}

    \titulo{\imprimirtituloPT}

    % Centraliza o caption das tabelas do IBGE, conforme recomendacao da USP
    \renewcommand{\configurecaptions}{\captionstyle[singlelinecheck=on]{}}
    
    % suporte a alguns sequencias comuns do LaTeX, como -- para travessao
    \ifxetex
        \defaultfontfeatures{Mapping=tex-text}
    \else
        \ifluatex
            \defaultfontfeatures{Mapping=tex-text}
            \setmainfont[Ligatures=TeX, SmallCapsFont={* Caps}]{Latin Modern Roman} 
        \fi
    \fi
    
    \pretextual
    
    % Capa
    \ifthenelse{\boolean{opt-impressao}}{}{
        \imprimircapa
    }

    % Folha de rosto e Ficha catalografica (se houver)
    \ifthenelse{\boolean{opt-fichacatalografica}}{
        % (o * indica que havera a ficha bibliografica)
        \imprimirfolhaderosto*{}
		\inserefichacatalografica
		\newpage
    }{
        \imprimirfolhaderosto{}
    }
    
    \setboolean{carimbo-folha-rosto}{false}
    \IfLangPortuguese{
        \begin{otherlanguage}{english}
            \imprimirfolhaderosto{}
        \end{otherlanguage}
    }{
        \begin{otherlanguage}{brazil}
            \imprimirfolhaderosto{}
        \end{otherlanguage}
    }

    % DEDICATORIA / AGRADECIMENTO / EPIGRAFE
    \inserededicatoria
    \insereagradecimentos
    \insereepigrafe

    % RESUMOS
    \insereresumo

    % Insere as Listas que forem setadas no documento
    \inserelistadefiguras
    \inserelistadequadros    
    \inserelistadetabelas
    \inserelistadesiglas
    \inserelistadesimbolos

	\pdfbookmark[0]{\contentsname}{toc}
    \tableofcontents*
    \cleardoublepage
    
   
    % Numeracao continua do elementos do presentes no documento
    \counterwithout{quadro}{chapter}
    
    \mainmatter

    % Retira espaco extra obsoleto entre as frases.
    \frenchspacing
}


\AtEndDocument{
    \ifthenelse{\boolean{opt-impressao}}{}{
        \includepdf[pages={1}]{packages/contra-capa.pdf}
    }
}

% ---
% Finaliza comandos com @ no nome
\makeatother
