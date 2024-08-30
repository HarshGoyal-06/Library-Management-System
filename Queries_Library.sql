/* #1- How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"? */

SELECT 
    copies.book_copies_BranchID AS [Branch ID], 
    branch.library_branch_BranchName AS [Branch Name],
    copies.book_copies_No_Of_Copies AS [Number of Copies],
    book.book_Title AS [Book Title]
FROM tbl_book_copies AS copies
INNER JOIN tbl_book AS book 
    ON copies.book_copies_BookID = book.book_BookID
INNER JOIN tbl_library_branch AS branch 
    ON copies.book_copies_BranchID = branch.library_branch_BranchID
WHERE book.book_Title = 'The Lost Tribe' 
AND branch.library_branch_BranchName = 'Sharpstown';



/* #2- How many copies of the book titled "The Lost Tribe" are owned by each library branch? */

SELECT 
    copies.book_copies_BranchID AS [Branch ID], 
    branch.library_branch_BranchName AS [Branch Name],
    copies.book_copies_No_Of_Copies AS [Number of Copies],
    book.book_Title AS [Book Title]
FROM tbl_book_copies AS copies
INNER JOIN tbl_book AS book 
    ON copies.book_copies_BookID = book.book_BookID
INNER JOIN tbl_library_branch AS branch 
    ON copies.book_copies_BranchID = branch.library_branch_BranchID
WHERE book.book_Title = 'The Lost Tribe';



/* #3- Retrieve the names of all borrowers who do not have any books checked out. */
		
SELECT borrower_BorrowerName 
FROM tbl_borrower
WHERE NOT EXISTS
    (SELECT * 
     FROM tbl_book_loans
     WHERE book_loans_CardNo = tbl_borrower.borrower_CardNo);



/* #4- For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.  */

SELECT 
    Branch.library_branch_BranchName AS [Branch Name],  
    Book.book_Title AS [Book Name],
    Borrower.borrower_BorrowerName AS [Borrower Name], 
    Borrower.borrower_BorrowerAddress AS [Borrower Address],
    Loans.book_loans_DateOut AS [Date Out], 
    Loans.book_loans_DueDate AS [Due Date]
FROM tbl_book_loans AS Loans
INNER JOIN tbl_book AS Book 
    ON Loans.book_loans_BookID = Book.book_BookID
INNER JOIN tbl_borrower AS Borrower 
    ON Loans.book_loans_CardNo = Borrower.borrower_CardNo
INNER JOIN tbl_library_branch AS Branch 
    ON Loans.book_loans_BranchID = Branch.library_branch_BranchID
WHERE 
    Loans.book_loans_DueDate = GETDATE() 
    AND Branch.library_branch_BranchName = 'Sharpstown';



/* #5- For each library branch, retrieve the branch name and the total number of books loaned out from that branch.  */

SELECT  
    Branch.library_branch_BranchName AS [Branch Name], 
    COUNT(Loans.book_loans_BranchID) AS [Total Loans]
FROM tbl_book_loans AS Loans
INNER JOIN tbl_library_branch AS Branch 
    ON Loans.book_loans_BranchID = Branch.library_branch_BranchID
GROUP BY Branch.library_branch_BranchName;



/* #6- Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out. */

SELECT 
    Borrower.borrower_BorrowerName AS [Borrower Name], 
    Borrower.borrower_BorrowerAddress AS [Borrower Address],
    COUNT(Borrower.borrower_BorrowerName) AS [Books Checked Out]
FROM tbl_book_loans AS Loans
INNER JOIN tbl_borrower AS Borrower 
    ON Loans.book_loans_CardNo = Borrower.borrower_CardNo
GROUP BY 
    Borrower.borrower_BorrowerName, 
    Borrower.borrower_BorrowerAddress
HAVING COUNT(Borrower.borrower_BorrowerName) >= 5;



/* #7- For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".*/

SELECT 
    Branch.library_branch_BranchName AS [Branch Name], 
    Book.book_Title AS [Title], 
    Copies.book_copies_No_Of_Copies AS [Number of Copies]
FROM tbl_book_authors AS Authors
INNER JOIN tbl_book AS Book 
    ON Authors.book_authors_BookID = Book.book_BookID
INNER JOIN tbl_book_copies AS Copies 
    ON Authors.book_authors_BookID = Copies.book_copies_BookID
INNER JOIN tbl_library_branch AS Branch 
    ON Copies.book_copies_BranchID = Branch.library_branch_BranchID
WHERE 
    Branch.library_branch_BranchName = 'Central' 
    AND Authors.book_authors_AuthorName = 'Stephen King';
