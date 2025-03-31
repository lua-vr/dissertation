$pdf_mode = 1;
$postscript_mode = $dvi_mode = 0;
$aux_dir = ".tex-aux";
$bibtex_use = 1;
$ENV{'TEXINPUTS'}='./packages//:';

system("mkdir -p $aux_dir/chapters;");

set_tex_cmds( '-synctex=1 %O %S' );

add_cus_dep('glo', 'gls', 0, 'makeglossaries');
sub makeglossaries {
   my ($base_name, $path) = fileparse( $_[0] );
   pushd $path;
   my $return = system "makeglossaries $base_name";
   popd;
   return $return;
}

add_cus_dep( 'nlo', 'nls', 0, 'makenlo2nls' );
sub makenlo2nls {
 my ($base_name, $path) = fileparse( $_[0] );
 pushd $path;
 my $return = system "makeindex -s nomencl.ist -o \"$base_name.nls\" \"$base_name.nlo\"";
 popd;
 return $return;
}
