describe('Visit The Website', () => {
  it('successfully loads', () => {
    cy.visit('/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Adds an item to cart with an empty cart", () => {
    cy.get('a.nav-link').contains('My Cart (0)')
    cy.get('.products article').first().find('button[type="submit"]').click({ force: true });
    cy.get('a.nav-link').contains('My Cart (1)').should('exist');
  })

  it("Adds a new item to an existing cart", () => {
    cy.visit('/')
    cy.get('a.nav-link').contains('My Cart (0)')
    cy.get('.products article').first().find('button[type="submit"]').click({ force: true });
    cy.get('a.nav-link').contains('My Cart (1)').should('exist');
    cy.get('.products article').eq(1).find('button[type="submit"]').click({ force: true });
    cy.get('a.nav-link').contains('My Cart (2)').should('exist');
  })
})
