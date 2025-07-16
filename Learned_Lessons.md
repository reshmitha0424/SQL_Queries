# SQL Practice Notes – July 15

## 1. What is an ENUM in SQL?
- `ENUM` is a MySQL-specific data type for string columns with a fixed set of allowed values.
- Ensures only predefined values can be inserted (e.g., `'cat'`, `'dog'`, `'rabbit'`).
- Example:
  ```sql
  CREATE TABLE Pets (
      name VARCHAR(50),
      type ENUM('cat', 'dog', 'rabbit')
  );


---

## 2. How to get only the rows where the column value is NULL?

* Use:

  ```sql
  SELECT * FROM table_name
  WHERE column_name IS NULL;
  ```
* Avoid using `= NULL`, which is invalid SQL.

---

## 3. If the value doesn’t exist, show NULL instead

* Use `LEFT JOIN` to include all rows from one table and show `NULL` if no match:

  ```sql
  SELECT a.id, b.value
  FROM A a
  LEFT JOIN B b ON a.id = b.id;
  ```
* You can also use:

  ```sql
  SELECT (SELECT column FROM table WHERE condition) AS result;
  ```

  This returns `NULL` if no value is found.

---

## 4. LeetCode Problem: Show employee unique IDs (or NULL if missing)

* Goal: For each employee, show their `unique_id` if they have one; otherwise, show `NULL`.
* Query:

  ```sql
  SELECT unique_id, name
  FROM Employees
  LEFT JOIN EmployeeUNI USING (id);
  ```

---

## 5. LeetCode Problem: Count how many visits didn’t result in transactions

* Approach:

  1. Use `LEFT JOIN` from `Visits` to `Transactions` on `visit_id`.
  2. Filter rows where `Transactions.visit_id IS NULL`.
  3. Group by `customer_id` and count the rows.
* Query:

  ```sql
  SELECT v.customer_id, COUNT(*) AS count_no_trans
  FROM Visits v
  LEFT JOIN Transactions t ON v.visit_id = t.visit_id
  WHERE t.transaction_id IS NULL
  GROUP BY v.customer_id;
  ```

---

## 6. Join Types: INNER JOIN, LEFT JOIN, RIGHT JOIN

### INNER JOIN

* Returns rows with matches in **both tables**.

```sql
SELECT A.name, B.salary
FROM Employees A
INNER JOIN Salaries B ON A.emp_id = B.emp_id;
```

### LEFT JOIN

* Returns **all rows from the left table**, and matches from the right table (or NULL).

```sql
SELECT A.name, B.salary
FROM Employees A
LEFT JOIN Salaries B ON A.emp_id = B.emp_id;
```

### RIGHT JOIN

* Returns **all rows from the right table**, and matches from the left table (or NULL).

```sql
SELECT A.name, B.salary
FROM Employees A
RIGHT JOIN Salaries B ON A.emp_id = B.emp_id;
```

---

## 7. LeetCode Problem: Find days where temperature was higher than previous day

### Option 1: Self-Join (MySQL safe)

```sql
SELECT w1.id
FROM Weather w1
JOIN Weather w2 
  ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
WHERE w1.temperature > w2.temperature;
```

### Option 2: LAG() (MySQL 8+)

```sql
SELECT id
FROM (
    SELECT id, temperature,
           LAG(temperature) OVER (ORDER BY recordDate) AS prev_temp
    FROM Weather
) AS temp_data
WHERE temperature > prev_temp;
```

```

