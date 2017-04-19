# Kvtest


a small test for Ruby bindings for LMDB: https://github.com/minad/lmdb

    $ git clone https://github.com/mindreframer/kvtest
    $ cd kvtest
    $ bundle install
    $ bin/console

    # this will create 100_000 small records
    > DbWrapper.generate
    > DbWrapper.show_stats
    > DbWrapper.get("key_99999")
    > DbWrapper.get("key_444")
    > DbWrapper.get("key_1")
    > DbWrapper.get("key_0")
    => nil
