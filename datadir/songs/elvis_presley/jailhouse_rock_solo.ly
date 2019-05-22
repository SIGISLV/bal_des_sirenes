\include "../_lilypond/header"
#(define (tie::tab-clear-tied-fret-numbers grob)
   (let* ((tied-fret-nr (ly:spanner-bound grob RIGHT)))
      (ly:grob-set-property! tied-fret-nr 'transparent #t)))

\paper {
  paper-height = 4\cm
  paper-width= 8\cm
  line-width= 8\cm
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
   %\tempo 4=170
   \clef #(if $inTab "tab" "treble_8")
   \key e \major
   \time 4/4
   \oneVoice
   r8  \ottava #1 <e''\1 b'\2 g'\3 >8 \ottava #0  \ottava #1 <e''\1 b'\2 g'\3 >8 \ottava #0  \ottava #1 <e''~\1 b'~\2 g'~\3 >8 \ottava #0  \ottava #1 <e''\1 b'\2 g'\3 >8 \ottava #0 <g'\3>8  \ottava #1 <e''\1 b'\2 g'\3 >8 \ottava #0  \ottava #1 <e''~\1 b'~\2 g'~\3 >8 \ottava #0 
    \ottava #1 <e''\1 b'\2 g'\3 >8 \ottava #0 <g'\3>8  \ottava #1 <e''\1 b'\2 g'\3 >8 \ottava #0  \ottava #1 <e''~\1 b'~\2 g'~\3 >8 \ottava #0  \ottava #1 <e''\1 b'\2 g'\3 >8 \ottava #0  \ottava #1 <e''\1 b'\2 g'\3 >8 \ottava #0  \ottava #1 <e''\1 b'\2 g'\3 >8 \ottava #0 r8 
   r8 <gis'\2 \bendAfter #+6 g'\3 >4 <gis'~\2 \bendAfter #+6 g'~\3 >8 <gis'\2 g'\3 >8 <gis'\2>8 <gis'\2>8 <gis'~\2>8 
   <gis'\2>8 <gis'\2 \bendAfter #+6 g'\3 >8 <gis'\2>8 <gis'~\2>8 <gis'\2>8 <gis'\2>8 <gis'\2>8 <\parenthesize b'\1 \parenthesize fis'\2 >8 
   <\parenthesize b\4 \parenthesize fis\5 \parenthesize b,\6 >8 <b\4 fis\5 b,\6 >8 <b\4 fis\5 b,\6 >8 <b~\4 fis~\5 b,~\6 >8-> <b\4 fis\5 b,\6 >8 <b\4 fis\5 b,\6 >8 <b\4 fis\5 b,\6 >8 <a~\4 e~\5 a,~\6 >8 
   <a\4 e\5 a,\6 >8 <a\4 e\5 a,\6 >8 <a\4 e\5 a,\6 >8 <a~\4 e~\5 a,~\6 >8-> <a\4 e\5 a,\6 >8 <a\4 e\5 a,\6 >8 <a\4 e\5 a,\6 >8 r8 
   <e\4 b,\5 e,\6 >8 <e\4 b,\5 e,\6 >8 <a\3 e\4 >8 <a\3 e\4 >8 <e\4 b,\5 e,\6 >8 <e\4 b,\5 e,\6 >8 <a\3 e\4 >8 <a\3 e\4 >8 
   <gis\3 e\4 b,\5 >8 <gis\3 e\4 b,\5 >8 <gis\3 e\4 b,\5 >8 <e\4 b,\5 e,\6 >8 r8 <g'\2 dis'\3 ais\4 dis\5 >4.-> 
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
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackAVoiceAMusic ##f
   }
   \context Voice = "TrackAVoiceBMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
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
  % \TrackAStaff
   \TrackATabStaff
>>
\score {
   \TrackAStaffGroup
   \header {
      title = "Jailhouse Rock" 
      composer = "Jerry Leiber & Mike Stoller" 
   }
}
