\language "english"
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
   % \tempo 4=132
   \clef #(if $inTab "tab" "treble_8")
   \key c \major
   \time 4/4
   \oneVoice
   <b~\2>2 <b\2>8 <as'\2>8 <gs'\2>8 <fs'\3>16 <ds'~\3>16 
   <ds'\3>8 r8 r4 r16 <as\4>16 <cs'\4>8 <cs'\4>8 <cs'\4>16 <ds'~\3>16 
   <ds'\3>4 r4 r8 <as'\2>8  \ottava #1 <cs''\1>8 \ottava #0  \ottava #1 <ds''\1>8 \ottava #0 
   \grace <f'\1>64  \ottava #1 <ds''\1>4 \ottava #0 r4 r8 \grace <c'\2>64 <as'\2>8 <gs'\3>8 <fs'\3>16 <gs'~\2>16 
   <gs'\2>16 <fs'\3>8. r4 r8  \ottava #1 <ds''\1>8 \ottava #0 \grace <as'\1>64  \ottava #1 <gs''\1>8 \ottava #0 \grace <as'\1>64  \ottava #1 <gs''\1>8 \ottava #0 
    \ottava #1 <fs''\1>4. \ottava #0 r8  \ottava #1 <ds''~\1>8 \ottava #0  \ottava #1 <ds''\1>16 \ottava #0 r4 r16 
    \ottava #1 <ds''\1>4 \ottava #0 r4 r8 <as\4>16 <as\4>16 <cs'\4>16 <ds'\3>16 <fs'\3>8 
   <ds'\3>2 r8 <a'\2>16 <gs'\2>16 <a'\2>16 <gs'\2>16 <fs'\3>8 
   <as'\2>1 
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
      \removeWithTag #'texts
      \TrackAVoiceAMusic  ##f
   }
    \context Voice = "TrackAVoiceBMusic" {
      \removeWithTag #'texts
      \TrackAVoiceBMusic ##f
   }
>>
TrackATabStaff = \new TabStaff \with { stringTunings = #`( ,(ly:make-pitch 0 2 NATURAL) ,(ly:make-pitch -1 6 NATURAL) ,(ly:make-pitch -1 4 NATURAL) ,(ly:make-pitch -1 1 NATURAL) ,(ly:make-pitch -2 5 NATURAL) ,(ly:make-pitch -2 2 NATURAL) ) } <<
   \context TabVoice = "TrackAVoiceAMusic" {
      \removeWithTag #'chords
      \removeWithTag #'texts
      \TrackAVoiceAMusic  ##t
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
   % \header {
   %   title = "Quand la Musique Est Bonne" 
   %   composer = "Jean-Jacques Goldman" 
   % }
}
