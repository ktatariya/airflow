--staging_order_reviews.sql
MERGE INTO ecommerce.staging.olist_order_reviews_dataset AS target
USING (
    SELECT DISTINCT
        review_id ,
        order_id ,
        review_score ,
        review_comment_title ,
        review_comment_message ,
        review_creation_date ,
        review_answer_timestamp ,
        r.load_id ,
        r.file_id , 
        %(unique_key)s AS unique_key  -- Use the unique_key value directly
    FROM raw.olist_order_reviews_dataset r
    JOIN meta.olist_order_reviews_dataset m
    ON r.load_id = m.load_id
        AND r.file_id = m.file_id
) AS source
    ON target.review_id = source.review_id
        AND target.unique_key = source.unique_key  -- Match on unique_key
        AND target.order_id = source.order_id
        AND target.review_answer_timestamp = source.review_answer_timestamp

WHEN MATCHED THEN
    UPDATE SET 
        target.review_id = source.review_id ,
        target.order_id = source.order_id ,
        target.review_score = source.review_score ,
        target.review_comment_title = source.review_comment_title ,
        target.review_comment_message = source.review_comment_message ,
        target.review_creation_date = source.review_creation_date ,
        target.review_answer_timestamp = source.review_answer_timestamp ,
        target.load_id = source.load_id ,
        target.file_id = source.file_id 
WHEN NOT MATCHED THEN
    INSERT (
        review_id ,
        order_id ,
        review_score ,
        review_comment_title ,
        review_comment_message ,
        review_creation_date ,
        review_answer_timestamp ,
        load_id ,
        file_id , 
        unique_key
    ) VALUES (
        source.review_id ,
        source.order_id ,
        source.review_score ,
        source.review_comment_title ,
        source.review_comment_message ,
        source.review_creation_date ,
        source.review_answer_timestamp ,
        source.load_id ,
        source.file_id ,
        source.unique_key 
    );
