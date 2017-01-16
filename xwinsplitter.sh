#!/bin/bash
# Description: Tiling on JWM. Move active window to the right, left, top, bottom half section of the screen.

WIN_ID=$1
QUADRANT=$(echo $2 | tr '[:upper:]' '[:lower:]')

MARGIN_LEFT=$3
MARGIN_TOP=$4
MARGIN_RIGHT=$5
MARGIN_BOTTOM=$6

MARGIN_LEFT=0
MARGIN_TOP=0
MARGIN_RIGHT=0
MARGIN_BOTTOM=55


# Get width of screen and height of screen
SCREEN_WIDTH=$(xwininfo -root | awk '$1=="Width:" {print $2}')
SCREEN_HEIGHT=$(xwininfo -root | awk '$1=="Height:" {print $2}')

### Calculate the window decorations(title bar height, borders)
#WIN_ID=$(xprop -root 32x '\t$0' _NET_ACTIVE_WINDOW | cut -f 2) # OR: xprop -root _NET_ACTIVE_WINDOW
# xprop lists the sizes in this order: left, right, top, bottom
WIN_DECORATION=$(xprop -id ${WIN_ID} | grep FRAME_EXTENTS )
WIN_DECORATION_LEFT=$(echo "${WIN_DECORATION}" | cut -d '=' -f 2 | tr -d ' ' | cut -d ',' -f 1)
WIN_DECORATION_RIGHT=$(echo "${WIN_DECORATION}"| cut -d '=' -f 2 | tr -d ' ' | cut -d ',' -f 2)
WIN_DECORATION_TOP=$(echo "${WIN_DECORATION}" | cut -d '=' -f 2 | tr -d ' ' | cut -d ',' -f 3)
WIN_DECORATION_BOTTOM=$(echo "${WIN_DECORATION}"| cut -d '=' -f 2 | tr -d ' ' | cut -d ',' -f 4)


### Get active window dimensions
WIN_WIDTH=$(xwininfo -id ${WIN_ID} | grep Width | tr -s ' ' | cut -d' ' -f3)
WIN_HEIGHT=$(xwininfo -id ${WIN_ID} | grep Height | tr -s ' ' | cut -d' ' -f3)

echo "MENU_BAR_HEIGHT: $MARGIN_BOTTOM"
echo "Fullscreen(W x H): $SCREEN_WIDTH x $SCREEN_HEIGHT"
echo "Target Window id: ${WIN_ID}"
echo "Target Window(W x H): ${WIN_WIDTH} x ${WIN_HEIGHT}"
echo "WIN_DECORATION(left, right, top, bottom): ${WIN_DECORATION}"

VIEW_WIDTH=$(( $SCREEN_WIDTH - $MARGIN_LEFT - $MARGIN_RIGHT ))
VIEW_HEIGHT=$(( $SCREEN_HEIGHT - $MARGIN_TOP - $MARGIN_BOTTOM - $WIN_DECORATION_TOP - $WIN_DECORATION_BOTTOM ))

### Move window to the corresponding section of the screen.
case "${QUADRANT}" in
  
  top|up)
    X=$(( $MARGIN_LEFT ))
    Y=$(( $MARGIN_TOP  ))
    W=$(( $VIEW_WIDTH ))
    H=$(( $VIEW_HEIGHT/2 ))
    
    ;;
        
  bottom|down)
    X=$(( $MARGIN_LEFT ))
    Y=$(( $MARGIN_TOP + ($VIEW_HEIGHT/2) + $WIN_DECORATION_TOP + $WIN_DECORATION_BOTTOM ))
    W=$(( $VIEW_WIDTH ))
    H=$(( $VIEW_HEIGHT/2 ))
    ;;

  left)
    X=$(( $MARGIN_LEFT ))
    Y=$(( $MARGIN_TOP  ))
    W=$(( $VIEW_WIDTH/2 ))
    H=$(( $VIEW_HEIGHT ))
    
    ;;

  right)
    X=$(( $MARGIN_LEFT + $VIEW_WIDTH/2 ))
    Y=$(( $MARGIN_TOP  ))
    W=$(( $VIEW_WIDTH/2 ))
    H=$(( $VIEW_HEIGHT ))
    ;;
    
  *)
    echo "ERROR: Please provide section input(i.e. left, right, top or bottom)"
    echo "   e.g. $@"
    echo "   e.g. $0 right"
    exit 1
    ;;
esac


echo "Y -> top + height + bottom: $Y -> $WIN_DECORATION_TOP + $H + $WIN_DECORATION_BOTTOM"
echo "X+Y(WxH): $X+$Y (${W} x ${H})"
# When resizing a window, the window must not be in a maximized state.
wmctrl -i -r ${WIN_ID} -b remove,maximized_vert,maximized_horz && wmctrl -i -r ${WIN_ID} -e 0,$X,$Y,$W,$H
wmctrl -lG | grep ${WIN_ID} 