describe('Visit The Website', () => {
  it('successfully loads', () => {
    cy.visit('/')
  })

  it("There is products on the page", () => {
  cy.get(".products article").should("have.length", 2);
});
})
