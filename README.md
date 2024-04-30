
# Tantivy tokenizer / Czech stemmer

This library bundles several OSS to provide [Czech language](https://en.wikipedia.org/wiki/Czech_language) stemmer as a Tantivy tokenizer. [Tantivy](https://github.com/quickwit-oss/tantivy) is a full-text search engine library written in Rust. As its default Tokenizer depends on a dead library `rust-stemmers`, there are only a very few languages available by default. Nevertheless, Tantivy provides a way to build custom tokenizers (see the [tantivy-tokenizer-api](https://crates.io/crates/tantivy-tokenizer-api) for details).

This repository bundles several OSS projects into 1 library:
- **Algorithms**

  Currently only a single algorithm (in an `aggressive` and `light` variants) is available: `Dolamic`. This algorithm has been developed by Ljiljana Dolamic & Jacques Savoy and published under the BSD license. It's written in the [Snowball language](https://snowballstem.org/) on is available on the [Snowball website](https://snowballstem.org/algorithms/czech/stemmer.html).

  *There is 1 more stemming algorithm for the Czech language: `Hellebrand`. This algorithm has been developed by David Hellebrand & Petr Chmelař. It's also written in the Snowball language and is available as a [Master's thesis here](https://www.fit.vut.cz/research/product/133). However, this algorithm has been published under the GNU license and **is therefore not included in this library as we'd like to keep BSD license** on this library.*
- [`rust-stemmers`](https://github.com/CurrySoftware/rust-stemmers)

  This library (used by Tantivy under the hood) implements a Rust interface for a Snowball algorithms of several languages. This library is inspired by `rust-stemmers` and some source code taken directly from `rust-stemmers` (namely `src/snowball/*`).
- [`Tantivy`](https://github.com/quickwit-oss/tantivy)

  Tokenizer in this library is mostly a copy of the original (official) implementation of the [`Stemmer` tokenizer](https://github.com/quickwit-oss/tantivy/blob/main/src/tokenizer/stemmer.rs) in the Tantivy library. Only instead of different languages, there are different algorithms for the Czech languages available. And instead of importing from the `tantivy` lib, this library imports from `tantivy-tokenizer-api`.
