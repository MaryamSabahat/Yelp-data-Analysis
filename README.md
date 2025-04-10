# Yelp Dataset Analysis with Snowflake & AWS S3

This project demonstrates how to process and analyze the [Yelp Open Dataset](https://business.yelp.com/data/resources/open-dataset/) using AWS S3, Snowflake, and Python for sentiment analysis. The data is transformed from JSON to tabular format, loaded into Snowflake, and queried for insights.

---

## 🚀 Tech Stack

- **Data Source:** Yelp Open Dataset
- **Cloud Storage:** AWS S3
- **Data Warehouse:** Snowflake
- **Scripting Language:** SQL, Python (UDF)
- **Python Library for NLP:** TextBlob
- **Tools:** Jupyter Notebook / VS Code (optional)

---

## 📁 Folder Structure

yelp-data-analysis/ ├── data/ # Instructions or placeholders for dataset ├── scripts/ # All SQL and Python scripts └── README.md # Project overview and guide


---

## 📦 Dataset

The dataset used in this project can be downloaded from:
👉 https://business.yelp.com/data/resources/open-dataset/

> ⚠️ Note: The dataset is quite large (8+ GB uncompressed). Upload to `AWS S3` before executing SQL scripts.

---

## 🛠️ Setup & Steps

1. **Download & Extract Dataset**  
   - Unzip the `.tar` file using Python to avoid file corruption.
2. **Upload Files to AWS S3**
   - Bucket: `yelp-project01`
3. **Connect AWS S3 with Snowflake**
   - Set IAM roles, trust relationships, and policies.
4. **Create Snowflake Tables**
   - Run scripts to create raw and tabular data tables.
5. **Sentiment Analysis**
   - Use Python UDF in Snowflake using `TextBlob`.
6. **Run Analytical Queries**
   - Execute business-related insights queries from `analysis_queries.sql`.

---

## 📊 Sample Queries Included

- Number of businesses per category
- Most active reviewers in the Restaurants category
- Top categories by review count
- Recent reviews for each business
- 5-star review percentage by business
- Average rating of businesses with 100+ reviews
- Positive sentiment analysis

---

## 📄 License

MIT License – feel free to use and adapt this project with credit.
