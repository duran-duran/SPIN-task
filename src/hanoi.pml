typedef piece {
  byte type;
  byte size;
}

typedef tower {
  piece p[4];
  byte q;
}

tower t[3];

active proctype HanoiDoubleTowers() {
  t[0].q = 2;
  t[0].p[0].type = 1;
  t[0].p[0].size = 2;
  t[0].p[1].type = 1;
  t[0].p[1].size = 1;

  t[1].q = 0;

  t[2].q = 2;
  t[2].p[0].type = 2;
  t[2].p[0].size = 2;
  t[2].p[1].type = 2;
  t[2].p[1].size = 1;

  byte i = 0, j = 1, tmp;

  REPEAT:
  if
  :: i = 0; j = 1;
  :: i = 1; j = 2;
  :: i = 0; j = 2;
  :: i = 1; j = 0;
  :: i = 2; j = 1;
  :: i = 2; j = 0;
  fi

  if
  :: (t[i].q > 0) -> 
     t[i].q = t[i].q - 1;
     t[j].p[t[j].q].type = t[i].p[t[i].q].type;
     t[j].p[t[j].q].size = t[i].p[t[i].q].size;
     t[j].q = t[j].q + 1;
     t[i].p[t[i].q].type = 0; 
     t[i].p[t[i].q].size = 0;
  :: else -> goto REPEAT;
  fi

  if
  :: ((t[0].q == 2) && (t[0].p[0].type == 2 && t[0].p[0].size == 2) && (t[0].p[1].type == 2 && t[0].p[1].size == 1)) &&
     ((t[2].q == 2) && (t[2].p[0].type == 1 && t[2].p[0].size == 2) && (t[2].p[1].type == 1 && t[2].p[1].size == 1)) ->
     goto FINISH;
  :: else -> goto REPEAT;
  fi

  FINISH:
}
