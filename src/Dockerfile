FROM ruby:2.7.2

WORKDIR /app
COPY Makefile Gemfile Gemfile.lock pet_sitter_app.gemspec run_pet_sitter_app.rb /app
COPY ./lib /app/lib

RUN make install

CMD ["ruby", "run_pet_sitter_app.rb"] 
