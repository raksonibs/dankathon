import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('memes-lettering', 'Integration | Component | memes lettering', {
  integration: true
});

test('it renders', function(assert) {
  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{memes-lettering}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#memes-lettering}}
      template block text
    {{/memes-lettering}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
