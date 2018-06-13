
jupyter_shutdown() {
        ps -ef | grep "[j]upyter" | sed -n 1p | for line in * ; do awk '{system("kill "$2)}' ; done
        echo "\nShut down Jupyter kernels."
}

lab () {
        # This kills Jupyter notebooks and lab on CTRL-C
        trap 'jupyter_shutdown; return' INT

        # Run the Jupyter Lab in the background
        echo -n "Starting Jupyter Lab... "
        (jupyter lab --no-browser > /dev/null 2>&1 &)
        sleep 1.0
        echo -n "Done.\n"

        # Print a pretty message
        toilet -f mono9 -F gay Jupyter Lab

        # Extract the Jupyter token (needed for authentication)
        TOKEN=$(jupyter notebook list | tail -n1 | python -c "import sys; print(next(sys.stdin)[29:77], end='')")

        # Let the user know what's going on
        echo -n $TOKEN | pbcopy
        echo "Copied token to clipboard!"
        echo -n "\nOpening application... "

        # Open the application!
        sleep 2.0
        osascript -e 'tell application "Jupyter Lab" to activate'

        sleep 1.0
        echo -n "Done."
        echo -n "\nURL: `jupyter notebook list | tail -n1`"
        echo -n "\nPress CTRL-C to exit..."
        while :; do sleep 2073600; done
}

notebook () {
        # This kills Jupyter notebooks and lab on CTRL-C
        trap 'jupyter_shutdown; return' INT

        # Run the Jupyter Lab in the background
        echo -n "Starting Jupyter Notebook... "
        (jupyter notebook --no-browser > /dev/null 2>&1 &)
        sleep 1.0
        echo -n "Done.\n"

        # Print a pretty message
        toilet -f mono9 -F gay "Notebook"

        # Extract the Jupyter token (needed for authentication)
        TOKEN=$(jupyter notebook list | tail -n1 | python -c "import sys; print(next(sys.stdin)[29:77], end='')")

        # Let the user know what's going on
        echo -n $TOKEN | pbcopy
        echo "Copied token to clipboard!"
        echo -n "\nOpening application... "

        # Open the application!
        sleep 2.0
        osascript -e 'tell application "Jupyter Notebook" to activate'

        sleep 1.0
        echo -n "Done."
        echo -n "\nURL: `jupyter notebook list | tail -n1`"
        echo -n "\nPress CTRL-C to exit..."
        while :; do sleep 2073600; done
}