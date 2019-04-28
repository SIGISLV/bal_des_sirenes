\include "../_lilypond/header"
\paper{paper-height = 2.6\cm}
{
   \tempo 4=132
   \clef #(if $inTab "tab" "treble_8")
   \key bes \major
   \time 4/4
   \oneVoice
   <bes'~\2>2 <bes'\2>8 <bes'\2>8 <aes'\2>8 <ges'\3>16 <ees'~\3>16 
   <ees'\3>8 r8 r4 r16 <bes\4>16 <des'\4>8 <des'\4>8 <des'\4>16 <ees'~\3>16 
   <ees'\3>4 r4 r8 <bes'\2>8  \ottava #1 <des''\1>8 \ottava #0  \ottava #1 <ees''\1>8 \ottava #0 
   \grace <f'\1>64  \ottava #1 <ees''\1>4 \ottava #0 r4 r8 \grace <c'\2>64 <bes'\2>8 <aes'\3>8 <ges'\3>16 <aes'~\2>16 
   <aes'\2>16 <ges'\3>8. r4 r8  \ottava #1 <ees''\1>8 \ottava #0 \grace <bes'\1>64  \ottava #1 <aes''\1>8 \ottava #0 \grace <bes'\1>64  \ottava #1 <aes''\1>8 \ottava #0 
    \ottava #1 <ges''\1>4. \ottava #0 r8  \ottava #1 <ees''~\1>8 \ottava #0  \ottava #1 <ees''\1>16 \ottava #0 r4 r16 
    \ottava #1 <ees''\1>4 \ottava #0 r4 r8 <bes\4>16 <bes\4>16 <des'\4>16 <ees'\3>16 <ges'\3>8 
   <ees'\3>2 r8 <a'\2>16 <aes'\2>16 <a'\2>16 <aes'\2>16 <ges'\3>8 
   <bes'\2>1 
   \bar "|."
}
