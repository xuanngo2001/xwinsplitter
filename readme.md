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
    xwinsplitter WINDOW_ID QUANDRANT
    
    # Move window(0x01200001) to quandrant 5.
    xwinsplitter 0x01200001 5

    # Resize window(0x01200001) to the full right quandrant.
    xwinsplitter 0x01200001 right
    