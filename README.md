Moneygraph is a project to use RDF, OWL ontologies, and graph databases to model and implement a personal investment portfolio database. Moneygraph will demonstrate how to grow an application by adding new connected data *before* adding new application code.


Moneygraph aims to provide a public, working, non-trivial example of the use of *gist*, an OWL-based upper ontology for business that is published and maintained by Semantic Arts Inc. https://www.semanticarts.com  of which I am an employee. It must be said that Moneygraph is my personal project and is in no way legally connected to Semantic Arts. But to Semantic Arts and Dave McComb, in particular, a great deal is owed.



What About FIBO?
For those in the know, FIBO is the Financial Industry Business Ontology. It is a well maintained, possibly widely used, OWL-based model of many parts of the financial services industry, with some areas modeled more completely than others. I found FIBO analogs for many of the Moneygraph classes, which were largely modeled from gist. FIBO could probably benefit from more application of the "catalog pattern" to reduce the number of sub-classes. 
FIBO is huge and a pretty big commitment, semantically speaking. Also, way too many prefixes and interdependent ontology files. So I have opted to make it an add-on, not one that is required for the Moneygraph model, but to which Moneygraph can be mapped using a SPARQL Update query. That's a future project. 