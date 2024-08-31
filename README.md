# Moneygraph


Moneygraph is a semantic data project that makes use of RDF, OWL ontologies, and graph databases to model and implement a personal investment portfolio database.

Moneygraph aims to provide a public, working, non-trivial example of the use of *gist* (https://www.semanticarts.com/gist/) an OWL-based upper ontology for business that is published and maintained by Semantic Arts Inc., of which I am an employee. That said, Moneygraph is my personal project and is in no way legally connected to Semantic Arts. But to Semantic Arts and Dave McComb, in particular, a great deal is owed.

The first title of Moneygraph was Questrade, named for https://www.questrade.com an online brokerage of which I am a client. The project began when I wanted to do more with the activities and report data that I downloaded from the Questrade website as Excel spreadsheets.


## gist Accounting
At about the same time that I was thinking of RDFifying Questrade, Dave McComb, my boss, had started developing gist Accounting, a gist-based model of accounting concepts that introduces many novel ideas.

## e tu, FIBO?
For those in the know, FIBO is the Financial Industry Business Ontology. It is a well maintained, widely used, OWL-based model of many parts of the financial services industry. I have found FIBO analogs for many of the Moneygraph classes, which were largely modeled from gist.
FIBO is huge and a pretty big commitment, semantically speaking, so I have opted to make it an add-on. I plan to build a crosswalk between Moneygraph and FIBO, but that must wait for now.

## Moneygraph
Most of the project, code-wise, is represented in the SPARQL CONSTRUCT scripts located in the tarql directory. The scripts convert CSV data in the Questrade format into triples that conform to gist: and the Moneygraph ontology. The CONSTRUCTS are executed by Sparql.Anything, a terrific open-source tool, one use of which is to convert CSV files into RDF triples in various formats (e.g. Turtle, N-triples). There are a few shell scripts (in bin/) that run Sparql.Anything on various report files and push the results to a triplestore as a RESTful call over http.

In ontologies/ you will find the main ontology file, moneygraph.ttl, and several supporting ontology files on which moneygraph.ttl depends.

.. MORE TO COME ...

