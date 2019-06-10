\include "../_lilypond/header"
#(define (tie::tab-clear-tied-fret-numbers grob)
   (let* ((tied-fret-nr (ly:spanner-bound grob RIGHT)))
      (ly:grob-set-property! tied-fret-nr 'transparent #t)))

\version "2.14.0"
\paper {
  paper-height = 1.2\cm
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
      \override Stem #'transparent = ##f
      \override Beam #'transparent = ##f
      \override Tie  #'after-line-breaking = #tie::tab-clear-tied-fret-numbers
   }
   \context { \StaffGroup
      \consists "Instrument_name_engraver"
   }
}
TrackAVoiceAMusic = #(define-music-function (parser location inTab) (boolean?)
#{
   %\tempo 4=146
   \clef #(if $inTab "tab" "treble_8")
   \key a \major
   \time 4/4
   \oneVoice
   <a'\1>8 <a'\1>8 <a'\1>8 <e'\1>8 <g'\2>8 <g'\2>8 <g'\2>8 <b\2>8 
   <fis'\2>8 <fis'\2>8 <fis'\2>8 <b\2>8 <f'\2>8 <f'\2>8 <f'\2>8 <b\2>8 
   <e'\2>8 r8 r4 r2 
   <e'\2>8 <fis'\2>8 <gis'\1>8 <a'\1>8 r4 <a'~\1 e'~\2 cis'~\3 a~\4 e~\5 a,~\6 >4 
   <a'\1 e'\2 cis'\3 a\4 e\5 a,\6 >1 
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
   \TrackATabStaff
>>
\score {
   \TrackAStaffGroup
   \header {
      title = "Rock Around The Clock" 
      composer = "John Taylor" 
   }
}
