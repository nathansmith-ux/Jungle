describe('Visit The Website', () => {
  it('successfully loads', () => {
    cy.visit('/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

  it("Views a product page", () => {
    cy.get('img[alt="Specific Product Name"]').click();
  })
})
