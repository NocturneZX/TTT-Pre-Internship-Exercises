package org.util;

import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.*;
 
import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.IOUtils;

public class AWSStorageUtil {

    private BasicAWSCredentials credentials;
    private AmazonS3 s3;
    private String bucketName;
    private static volatile AWSStorageUtil  awsstorageUtil = new  AWSStorageUtil();


	private AWSStorageUtil() {
        
        this.credentials = new   BasicAWSCredentials("GET YOUR OWN","BLOODY KEY!");
        this.bucketName = "tttcameraappinfo";
        this.s3 = new AmazonS3Client(this.credentials);
        System.out.println("Amazon S3 Storage Connected");
	}
	
    public static AWSStorageUtil getInstance(){
        return awsstorageUtil;
    }   
	
    public void upload(File file){
    	System.out.println("Uploading File....."+file.getName());
        String key = "uploads/" + file.getName();
        s3.putObject(this.bucketName, key, file);
    }
    
    public void upload(FileItem item){
    	String fileName = item.getName();
       	System.out.println("Uploading File....."+fileName);
        String key = "uploads/" + fileName;
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(item.getSize());
        try{
        s3.putObject(new PutObjectRequest(bucketName, key, item.getInputStream(), metadata));
        }catch(Exception e){
        	e.printStackTrace();
        }
    }
    
    public void delete(String key){
    	if(key!=null){
    		System.out.println("Deleting File....."+key);
    		s3.deleteObject(bucketName, key);
    	}
    }

    
    public List<String> getFileList(String path){
        System.out.println("Listing Files In "+path);
        List<String> list = new ArrayList<String>();
        ObjectListing objectListing = s3.listObjects(new ListObjectsRequest()
                .withBucketName(bucketName)
                .withPrefix(path));
        for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
            System.out.println(" - " + objectSummary.getKey() + "  " +
                               "(size = " + objectSummary.getSize() + ")");
            list.add(objectSummary.getKey());
        }
        return list;
    }
 
    
    public byte[] getFileFromS3(String key){
        System.out.println("Downloading File......"+key);
        S3Object s3Object = s3.getObject(new GetObjectRequest(this.bucketName, key));
        System.out.println("Content-Type: "  + s3Object.getObjectMetadata().getContentType() + " Size: " + s3Object.getObjectMetadata().getContentLength());
        try {
        	return IOUtils.toByteArray(s3Object.getObjectContent());
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }  


 
}
