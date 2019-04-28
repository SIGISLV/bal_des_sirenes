#(define (tie::tab-clear-tied-fret-numbers grob)
   (let* ((tied-fret-nr (ly:spanner-bound grob RIGHT)))
      (ly:grob-set-property! tied-fret-nr 'transparent #t)))

\version "2.14.0"
\paper {
   indent = #0
   print-all-headers = ##t
   ragged-right = ##f
   ragged-bottom = ##t
}
\layout {
   \context { \Score
      \override MetronomeMark #'padding = #'5
   }
   \context { \Staff
      \override TimeSignature #'style = #'numbered
      \override StringNumber #'transparent = ##t
   }
   \context { \TabStaff
      \override TimeSignature #'style = #'numbered
      \override Stem #'transparent = ##t
      \override Beam #'transparent = ##t
      \override Tie  #'after-line-breaking = #tie::tab-clear-tied-fret-numbers
   }
   \context { \TabVoice
      \override Tie #'stencil = ##f
   }
   \context { \StaffGroup
      \consists "Instrument_name_engraver"
   }
}
TrackAVoiceAMusic = #(define-music-function (parser location inTab) (boolean?)
#{
   \tempo 4=132
   \clef #(if $inTab "tab" "treble_8")
   \key bes \major
   \time 4/4
   \oneVoice
   <g\3>8 r8 r4 r16 <d\4>16 <f\4>8 <f\4>8 <f\4>16 <g~\3>16 
   <g\3>4 r4 r8 <d'\2>8 <f'\1>8 <g'\1>8 
   \grace <f'\1>64 <g'\1>4 r4 r8 \grace <c'\2>64 <d'\2>8 <c'\3>8 <bes\3>16 <c'~\2>16 
   <c'\2>16 <bes\3>8. r4 r8 <g'\1>8 \grace <bes'\1>64 <c''\1>8 \grace <bes'\1>64 <c''\1>8 
   <bes'\1>4. r8 <g'~\1>8 <g'\1>16 r4 r16 
   <g'\1>4 r4 r8 <d\4>16 <d\4>16 <f\4>16 <g\3>16 <bes\3>8 
   <g\3>2 r8 <des'\2>16 <c'\2>16 <des'\2>16 <c'\2>16 <bes\3>8 
   <d'\2>1 
   \bar "|."
   \pageBreak
#})
TrackAVoiceBMusic = #(define-music-function (parser location inTab) (boolean?)
#{
#})
TrackALyrics = \lyricmode {
   \set ignoreMelismata = ##t
   
   \unset ignoreMelismata
}
TrackAStaff = \new Staff <<
   \context Voice = "TrackAVoiceAMusic" {
      \TrackAVoiceAMusic ##f
   }
   \context Voice = "TrackAVoiceBMusic" {
      \TrackAVoiceBMusic ##f
   }
>>
TrackATabStaff = \new TabStaff \with { stringTunings = #`( ,(ly:make-pitch 0 2 NATURAL) ,(ly:make-pitch -1 6 NATURAL) ,(ly:make-pitch -1 4 NATURAL) ,(ly:make-pitch -1 1 NATURAL) ,(ly:make-pitch -2 5 NATURAL) ,(ly:make-pitch -2 2 NATURAL) ) } <<
   \context TabVoice = "TrackAVoiceAMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackAVoiceAMusic ##t
   }
   \context TabVoice = "TrackAVoiceBMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackAVoiceBMusic ##t
   }
>>
TrackAStaffGroup = \new StaffGroup <<
   \TrackAStaff
   \TrackATabStaff
>>
TrackBVoiceAMusic = #(define-music-function (parser location inTab) (boolean?)
#{
   \tempo 4=132
   \clef #(if $inTab "tab" "treble_8")
   \key bes \major
   \time 4/4
   \oneVoice
   r8  \ottava #1 <d''~\1 bes'~\2 >8 \ottava #0  \ottava #1 <d''\1 bes'\2 >16 \ottava #0 <c''\1 a'\2 >8. <bes'\1 g'\2 >4 r4 
   r8  \ottava #1 <d''~\1 bes'~\2 >8 \ottava #0  \ottava #1 <d''\1 bes'\2 >16 \ottava #0 <c''\1 a'\2 >8. <bes'\1 g'\2 >4 r4 
   r8  \ottava #1 <d''~\1 bes'~\2 >8 \ottava #0  \ottava #1 <d''\1 bes'\2 >16 \ottava #0 <c''\1 a'\2 >8. <bes'\1 g'\2 >4 r4 
   r8  \ottava #1 <d''~\1 bes'~\2 >8 \ottava #0  \ottava #1 <d''\1 bes'\2 >16 \ottava #0 <c''\1 a'\2 >8. <bes'\1 g'\2 >4 r4 
   r8  \ottava #1 <d''~\1 bes'~\2 >8 \ottava #0  \ottava #1 <d''\1 bes'\2 >16 \ottava #0 <c''\1 a'\2 >8. <bes'\1 g'\2 >4 r4 
   r8  \ottava #1 <d''~\1 bes'~\2 >8 \ottava #0  \ottava #1 <d''\1 bes'\2 >16 \ottava #0 <c''\1 a'\2 >8. <bes'\1 g'\2 >4 r4 
   r8  \ottava #1 <d''~\1 bes'~\2 >8 \ottava #0  \ottava #1 <d''\1 bes'\2 >16 \ottava #0 <c''\1 a'\2 >8. <bes'\1 g'\2 >4 r4 
   r1 
   \bar "|."
   \pageBreak
#})
TrackBVoiceBMusic = #(define-music-function (parser location inTab) (boolean?)
#{
#})
TrackBLyrics = \lyricmode {
   \set ignoreMelismata = ##t
   
   \unset ignoreMelismata
}
TrackBStaff = \new Staff <<
   \context Voice = "TrackBVoiceAMusic" {
      \TrackBVoiceAMusic ##f
   }
   \context Voice = "TrackBVoiceBMusic" {
      \TrackBVoiceBMusic ##f
   }
>>
TrackBTabStaff = \new TabStaff \with { stringTunings = #`( ,(ly:make-pitch 0 2 NATURAL) ,(ly:make-pitch -1 6 NATURAL) ,(ly:make-pitch -1 4 NATURAL) ,(ly:make-pitch -1 1 NATURAL) ,(ly:make-pitch -2 5 NATURAL) ,(ly:make-pitch -2 2 NATURAL) ) } <<
   \context TabVoice = "TrackBVoiceAMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackBVoiceAMusic ##t
   }
   \context TabVoice = "TrackBVoiceBMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackBVoiceBMusic ##t
   }
>>
TrackBStaffGroup = \new StaffGroup <<
   \TrackBStaff
   \TrackBTabStaff
>>
\score {
   \TrackAStaffGroup
   \header {
      title = "" 
      composer = "" 
      instrument = "Track 1" 
   }
}
\score {
   \TrackBStaffGroup
   \header {
      title = "" 
      composer = "" 
      instrument = "Track 2" 
   }
}
