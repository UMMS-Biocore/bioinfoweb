DEDIR=/srv/shiny-server/debrowser/R
BDIR=/var/lib/shiny-server/bookmarks/shiny

if [ -d "$DEDIR/shiny_bookmarks" ]; then
   rm -rf $DEDIR/shiny_bookmarks 
   ln -s $BDIR/R-* $DEDIR/shiny_bookmarks
fi

if [ -d "$BDIR/shiny_saves" ]; then
  rm -rf $DEDIR/shiny_saves
  ln -s $BDIR/shiny_saves $DEDIR/shiny_saves
fi

