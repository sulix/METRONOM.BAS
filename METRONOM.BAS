' METRONOM.BAS: A Simple QBasic Metronome
'
'Copyright (C) 2024 David Gow <david@davidgow.net>
'
'Permission to use, copy, modify, and/or distribute this software for any
'purpose with or without fee is hereby granted.
'
'THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
'REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
'FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
'INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
'LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
'OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
'PERFORMANCE OF THIS SOFTWARE.

INPUT "Tempo (BPM)"; tempo
INPUT "Time signature (beats/bar)"; num%

period = 60 / tempo

count% = 0 ' Count down to beginning of next bar (0)
nexttick = TIMER + period ' Time of next beat
nextcol = nexttick - period / 2 ' Time of next colour change

' Loop
WHILE INKEY$ = ""
        IF count% = 0 THEN
                ' First beat of a bar: colour is green, pitch is high
                COLOR 15, 2
                CLS
                PRINT 1
                SOUND 880, 1
                count% = num%
        ELSE
                ' All other beats: colour is blue, pitch is low.
                COLOR 15, 1
                CLS
                PRINT num% - count% + 1
                SOUND 440, 1
        END IF

        ' Wait for the next beat
        WHILE TIMER < nexttick
                ' After half a beat...
                IF TIMER > nextcol THEN
                        ' Change the colour.
                        COLOR 7, 0
                        CLS
                        PRINT num% - count% + 1
                        nextcol = nexttick
                END IF
                IF INKEY$ <> "" THEN GOTO DONE
        WEND

        count% = count% - 1
        nexttick = nexttick + period
        nextcol = nexttick - period / 2
WEND

DONE:

' Reset the screen to normal colours.
COLOR 7, 0
CLS
END
