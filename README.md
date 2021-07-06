# CohortPairingGenerator

A simple tool which creates randomized student groupings weighted by the number of labs currently completed by each student as recorded in a Canvas gradebook.  The intention is that you can update the source CSV file so that if students catch-up, move-ahead or start lagging, they'll get roughly resorted according to their most recent progress.

## Installation

(Fork and) clone this repo

And then execute:

    $ bundle install

You may also want to have a CSV editing extension installed in VS Code.


## Usage

1. Export the gradebook for your current phase from the Canvas course for that phase. Export as CSV.
2. You may need to edit this CSV file (there are good extensions for this in VS Code) to normalize the data (remove blank lines, etc.)
3. From the directory root, execute the tool with `bin/run`
4. Follow the command-line prompts
5. Results print to console where you can copy/paste as needed.
6. You can rerun the generator with different sized groups.

