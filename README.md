# adventskalender

A mobile app which sends local notifications during advent in December.

## About

An *Advent calendar* is a special calendar used to count the days of Advent in anticipation of Christmas.

## Getting Started

If you would like to build the app yourself, then you simply need:

- Flutter >= 1.22
- Dart >= 2.10
- Xcode >= 11.5
- Android SDK >= 29.0.4

### Generating Database

- Duplicate the folder `assets_dev/database/template` (for instance *assets_dev/database/mydb*).
- Add 24 images numbered 1 to 24 with extensions type `jpeg` to this duplicated folder. You can rename *template.csv* if you like.
- Run the command `dart bin/db_importer -d <DIR>` where `<DIR>` is the name of the directory (i.e. `dart bin/db_importer -d mydb`).

For a complete example, take a look at cats.

## Contributing

The project isn't actively looking for contributors, however feel free to contact James here on GitHub or [Twitter](https://twitter.com/defuncart).

## Credits

Concept, Design and Programming by James Leahy.

All cat photos taken from [CATAAS](https://cataas.com/), text taken from [Random Cat Generator](https://www.springhole.net/writing_roleplaying_randomators/catcreator.htm).
