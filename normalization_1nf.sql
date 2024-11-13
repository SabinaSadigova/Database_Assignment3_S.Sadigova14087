DROP TABLE IF EXISTS public.wholenorm_nf;
--  Creating the wholenorm_1nf table with the desired columns
CREATE TABLE public.wholenorm_nf (
    "CRN" integer,
    "ISBN" integer,
    "Title" character(255),
    "Author" character(255),
    "Edition" integer,
    "Publisher" character(255),
    "Publisher address" character(255),
    "Pages" integer,
    "Year" integer,
    "Course name" character(255),
    PRIMARY KEY ("CRN", "ISBN", "Authors")
);

-- Spliting authors and insert each one into wholenorm_1nf
WITH split_authors AS (
    SELECT 
        "CRN", 
        "ISBN", 
        "Title", 
        unnest(string_to_array("Authors", ',')) AS "Author", -- Split authors by comma
        "Edition",
        "Publisher",
        "Publisher address",
        "Pages",
        "Year",
        "Course name"
    FROM public.wholenorm
)
INSERT INTO public.wholenorm_nf (
    "CRN", 
    "ISBN", 
    "Title", 
    "Author", 
    "Edition", 
    "Publisher", 
    "Publisher address", 
    "Pages", 
    "Year", 
    "Course name"
)
SELECT 
    "CRN", 
    "ISBN", 
    "Title", 
    trim("Author") AS "Author", -- Triming extra spaces around author names
    "Edition", 
    "Publisher", 
    "Publisher address", 
    "Pages", 
    "Year", 
    "Course name"
FROM split_authors;
