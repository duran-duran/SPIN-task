typedef piece {
  byte type;
  byte size;
}

typedef tower {
  piece p[4];
  byte q;
}

tower t[3];

active proctype Hanoi() {
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

  byte i = 0, j = 1;

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

#define a1 ((t[0].p[0].type == t[0].p[1].type) -> (t[0].p[0].size >= t[0].p[1].size))
#define a2 ((t[0].p[1].type == t[0].p[2].type) -> (t[0].p[1].size >= t[0].p[2].size))
#define a3 ((t[0].p[2].type == t[0].p[3].type) -> (t[0].p[2].size >= t[0].p[3].size))

#define b1 ((t[1].p[0].type == t[1].p[1].type) -> (t[1].p[0].size >= t[1].p[1].size))
#define b2 ((t[1].p[1].type == t[1].p[2].type) -> (t[1].p[1].size >= t[1].p[2].size))
#define b3 ((t[1].p[2].type == t[1].p[3].type) -> (t[1].p[2].size >= t[1].p[3].size))

#define c1 ((t[2].p[0].type == t[2].p[1].type) -> (t[2].p[0].size >= t[2].p[1].size))
#define c2 ((t[2].p[1].type == t[2].p[2].type) -> (t[2].p[1].size >= t[2].p[2].size))
#define c3 ((t[2].p[2].type == t[2].p[3].type) -> (t[2].p[2].size >= t[2].p[3].size))

ltl first{<>(((Hanoi@REPEAT) -> ((a1 && a2 && a3) && (b1 && b2 && b3) && (c1 && c2 && c3))) U (Hanoi@FINISH))}
