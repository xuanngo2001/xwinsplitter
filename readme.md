# xwinsplitter
Split / move windows

# Screen quadrant
    +-----------+    +-----------+    +-----------+
    | 7 | 8 | 9 |    |     |     |    |           |
    +-----------+    +     |     +    +     T     +
    | 4 | 5 | 6 |    |  L  |  R  |    |-----------|
    +-----------+    +     |     +    +           +
    | 1 | 2 | 3 |    |     |     |    |     B     |
    +-----------+    +-----------+    +-----------+

                      Left, Right      Top, Bottom
                      
# Usage
    xwinsplitter.sh <WINDOW_ID> <QUADRANT> [MARGIN_LEFT, MARGIN_TOP, MARGIN_RIGHT, MARGIN_BOTTOM]
    
    # Move window(0x01200001) to quadrant 5.
    xwinsplitter.sh 0x01200001 5

    # Resize window(0x01200001) to the full right quadrant.
    xwinsplitter.sh 0x01200001 right
    
    # Get active window ID
    xwinsplitter--id.sh :active:
    
    # Get window ID with title 'Terminal'
    xwinsplitter--id.sh Terminal
