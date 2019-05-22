\include "../_lilypond/header"
\language "english"
#(define (tie::tab-clear-tied-fret-numbers grob)
   (let* ((tied-fret-nr (ly:spanner-bound grob RIGHT)))
      (ly:grob-set-property! tied-fret-nr 'transparent #t)))

\version "2.14.0"
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
   \tempo 4=132
   \clef #(if $inTab "tab" "treble_8")
   \key c \major
   \time 4/4
   \oneVoice
    \ottava #1 <d''~\2>1 \ottava #0 
    \ottava #1 <d''~\2>2 \ottava #0  \ottava #1 <d''\2>8 \ottava #0  \ottava #1 <d''\2>8 \ottava #0 <c''\2>8 <ais'\3>16 <g'~\3>16 
   <g'\3>8 r8 r4 r16 <d'\4>16 <f'\4>8 <f'\4>8 <f'\4>16 <g'~\3>16 
   <g'\3>4 r4 r8  \ottava #1 <d''\2>8 \ottava #0  \ottava #1 <f''\1>8 \ottava #0  \ottava #1 <g''\1>8 \ottava #0 
   \grace <f'\1>64  \ottava #1 <g''\1>4 \ottava #0 r4 r8 \grace <c'\2>64  \ottava #1 <d''\2>8 \ottava #0 <c''\3>8 <ais'\3>16 <c''~\2>16 
   <c''\2>16 <ais'\3>8. r4 r8  \ottava #1 <g''\1>8 \ottava #0 \grace <ais'\1>64  \ottava #1 <c'''\1>8 \ottava #0 \grace <ais'\1>64  \ottava #1 <c'''\1>8 \ottava #0 
    \ottava #1 <ais''\1>4. \ottava #0 r8  \ottava #1 <g''~\1>8 \ottava #0  \ottava #1 <g''\1>16 \ottava #0 r4 r16 
    \ottava #1 <g''\1>4 \ottava #0 r4 r8 <d'\4>16 <d'\4>16 <f'\4>16 <g'\3>16 <ais'\3>8 
   <g'\3>2 r8  \ottava #1 <cis''\2>16 \ottava #0 <c''\2>16  \ottava #1 <cis''\2>16 \ottava #0 <c''\2>16 <ais'\3>8 
    \ottava #1 <d''~\2>1 \ottava #0 
    \ottava #1 <d''\2>1 \ottava #0 
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
   \TrackAStaff
   \TrackATabStaff
>>
\score {
   \TrackAStaffGroup
   \header {
      title = "Quand la Musique Est Bonne" 
      composer = "Jean-Jacques Goldman" 
   }
}
