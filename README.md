# README

I've built an app that parses and aggregates performances of top London theaters: Southbank Centre, National Theatre, Royal Opera House.

I wrote a parser for `What's On` page for each theatre using Nokogiri library. Check out `app/models/event_fetcher.rb` to see the parser code.

Each theatre has it's own filters, depends on information they provide on a website: by tags, by time, by price.

![Preview](/demonstration/perfomances_demonstration.gif)
