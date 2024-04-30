
# Tantivy tokenizer / Czech stemmer

This library bundles several OSS to provide [Czech language](https://en.wikipedia.org/wiki/Czech_language) stemmer as a Tantivy tokenizer. [Tantivy](https://github.com/quickwit-oss/tantivy) is a full-text search engine library written in Rust. As its default `Stemmer` tokenizer depends on a dead library `rust-stemmers`, there are only a very few languages available by default. Nevertheless, Tantivy provides an easy way to build our own custom tokenizers (see the [tantivy-tokenizer-api](https://crates.io/crates/tantivy-tokenizer-api) for details).

This repository bundles several OSS projects into 1 library:
- **Algorithms**

  Currently only a single algorithm (in an `aggressive` and `light` variants) is available: `Dolamic`. This algorithm has been developed by **Ljiljana Dolamic** & Jacques Savoy and published under the BSD license. It's written in the [Snowball language](https://snowballstem.org/) and is available on the [Snowball website](https://snowballstem.org/algorithms/czech/stemmer.html).

  *There is 1 more stemming algorithm for the Czech language: `Hellebrand`. This algorithm has been developed by **David Hellebrand** & Petr Chmelař. It's also written in the Snowball language and is available as a [Master's thesis here](https://www.fit.vut.cz/research/product/133). However, this algorithm has been published under the GNU license and **is therefore not included in this library as we'd like to keep the BSD license** on this library. (If you wish, you can always compile the `Hellebrand` algorithm from Snowball to Rust and include it yourself.)*
- [`rust-stemmers`](https://github.com/CurrySoftware/rust-stemmers)

  This library (used by Tantivy under the hood) implements a Rust interface for a Snowball algorithms of several languages. This library is inspired by `rust-stemmers` and some source code is taken directly from `rust-stemmers` (namely `src/snowball/*`).
- [`Tantivy`](https://github.com/quickwit-oss/tantivy)

  Implementation of the tokenizer in this library is mostly a copy of the original implementation of the [`Stemmer` tokenizer](https://github.com/quickwit-oss/tantivy/blob/main/src/tokenizer/stemmer.rs) in the Tantivy library. Only instead of different languages, there are available different algorithms for the Czech language. And instead of importing from the `tantivy` lib, this library imports from `tantivy-tokenizer-api`.

## Usage

```rs
use tantivy::schema::{Schema, TextFieldIndexing, TextOptions, IndexRecordOption};
use tantivy::Index;
use tantivy_czech_stemmer;

fn main() {
    let mut schema_builder = Schema::builder();

    schema_builder.add_text_field(
        "title",
        TextOptions::default()
            .set_indexing_options(
                TextFieldIndexing::default()
                    // Set name of the tokenizer, we will register it shortly
                    .set_tokenizer("lang_cs")
                    .set_index_option(IndexRecordOption::WithFreqsAndPositions),
            )
            .set_stored(),
    );

    let schema = schema_builder.build();
    let index = Index::create_in_ram(schema.clone());

    // Create an instance of the Czech stemmer tokenizer

    // With default algorithm (Dolamic aggressive)
    let stemmer_tokenizer = tantivy_czech_stemmer::tokenizer::Stemmer::default();

    // With a specific algorithm
    // let stemmer_tokenizer = tantivy_czech_stemmer::tokenizer::Stemmer::new(
    //     tantivy_czech_stemmer::tokenizer::Algorithm::DolamicLight,
    // );

    // Register the tokenizer with Tantivy
    index.tokenizers().register("lang_cs", stemmer_tokenizer);
}
```
