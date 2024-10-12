#!/bin/bash
set -e

usage() {
    echo "Usage: $0 -e <extension> -m <monthlyDir> -d <dailyDir> -t <targetFile>"
    echo "  -e, --extension     Specify the file extension"
    echo "  -m, --monthlyDir    Specify the monthly directory"
    echo "  -d, --dailyDir      Specify the daily directory"
    echo "  -t, --targetFile    Specify the target file"
    exit 1
}

PREFIX=""
EXTENSION=""
MONTH_DIR=""
DAILY_DIR=""
TARGET=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p|--prefix)
            PREFIX="$2"
            shift 2
            ;;
        -e|--extension)
            EXTENSION="$2"
            shift 2
            ;;
        -m|--monthlyDir)
            MONTH_DIR="$2"
            shift 2
            ;;
        -d|--dailyDir)
            DAILY_DIR="$2"
            shift 2
            ;;
        -t|--targetFile)
            TARGET="$2"
            shift 2
            ;;
        *)
            echo "Unknown parameter passed: $1"
            usage
            ;;
    esac
done

if [[ -z "$EXTENSION" || -z "$TARGET" ]]; then
    echo "Error: Missing required parameters."
    usage
fi

# Current month (YYYY-MM)
MONTH=$(date "+%Y-%m")
# Current day (DD)
DAY=$(date "+%d")

if [[ "$MONTH_DIR" != "" ]]; then
    mkdir -p $MONTH_DIR
    FILENAME="$MONTH_DIR""/""$PREFIX""$MONTH"".""$EXTENSION"
    if [[ -f "$FILENAME" ]]; then
        echo "Skip monthly"
    else
        echo "Backup monthly: $FILENAME"
        cp $TARGET $FILENAME
    fi
fi

if [[ "$DAILY_DIR" != "" ]]; then
    mkdir -p $DAILY_DIR
    FILENAME="$DAILY_DIR""/""$PREFIX""$DAY"".""$EXTENSION"
    if [[ -f "$FILENAME" ]]; then
        echo "Remove old daily"
        rm -f $FILENAME
    fi
    echo "Backup daily: $FILENAME"
    cp $TARGET $FILENAME
fi

