import streamlit as st
import boto3
import json
import sys
import os
from langchain.llms.bedrock import Bedrock
bedrock = boto3.client(service_name='bedrock-runtime', region_name='us-west-2')
boto3_bedrock = boto3.client(service_name='bedrock-runtime', region_name='us-west-2')
st.write("""
# Summarize text content 

""")
st.write("""
This app will use an **Amazon Bedrock** Titan model to summarize content of a text document.
         
*Example: An Email :email:*
""")

llm = Bedrock(
    model_id="amazon.titan-text-express-v1",
    model_kwargs={
        "maxTokenCount": 4096,
        "stopSequences": [],
        "temperature": 0,
        "topP": 1,
    },
    client=boto3_bedrock,
)
module_path = "."
sys.path.append(os.path.abspath(module_path))
uploaded_files = st.file_uploader("Choose a Text file", accept_multiple_files=True)
for uploaded_file in uploaded_files:
    bytes_data = uploaded_file.read()
    st.write("filename:", uploaded_file.name)
    letter = bytes_data.decode("utf-8")
    
    form = st.form(key='my_form')
    submit = form.form_submit_button('Submit') 
    if submit:  
        llm.get_num_tokens(letter)
        tab1, tab2, tab3 = st.tabs(["Summary Output","Number of files","Input Data"])
        with tab3:
            st.header("Input Data")
            st.markdown(letter)
        from langchain.text_splitter import RecursiveCharacterTextSplitter
        text_splitter = RecursiveCharacterTextSplitter(
            separators=["\n\n", "\n"], chunk_size=4000, chunk_overlap=100
        )

        docs = text_splitter.create_documents([letter])

        num_docs = len(docs)
        
        with st.spinner('Have Patience. Please wait for the number of files...'):
            num_tokens_first_doc = llm.get_num_tokens(docs[0].page_content)
            total_tokens = 0
            for doc in docs:
                total_tokens += llm.get_num_tokens(doc.page_content)
            with tab2:
                st.header("Number of files")
                st.markdown( f"Now we have {num_docs} documents and the first one has {num_tokens_first_doc} tokens. Total tokens {total_tokens}")
        st.success('Found the number of files!')
        with st.spinner('Have Patience. Please wait for the Summary output result...'):
            # Set verbose=True if you want to see the prompts being used
            from langchain.chains.summarize import load_summarize_chain
            summary_chain = load_summarize_chain(llm=llm, chain_type="map_reduce", verbose=False)
            output = summary_chain.run(docs)
            with tab1:
                st.header("Summary Output")
                st.markdown (output.strip())
        st.success('Summary output generated!')
        st.cache_data.clear()