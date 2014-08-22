/*
 * MATLAB Compiler: 4.17 (R2012a)
 * Date: Thu Apr 24 13:05:31 2014
 * Arguments: "-B" "macro_default" "-W" "java:smal,smalDetector" "-T" "link:lib" "-d" 
 * "D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\smal\\src" "-w" 
 * "enable:specified_file_mismatch" "-w" "enable:repeated_file" "-w" 
 * "enable:switch_ignored" "-w" "enable:missing_lib_sentinel" "-w" "enable:demo_license" 
 * "-v" 
 * "class{smalDetector:D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\classifier.m,D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\inremental.m,D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\metrics.m,D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\smal.m,D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\updateTraining.m}" 
 */

package smal;

import com.mathworks.toolbox.javabuilder.pooling.Poolable;
import java.util.List;
import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * The <code>smalDetectorRemote</code> class provides a Java RMI-compliant interface to 
 * the M-functions from the files:
 * <pre>
 *  D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\classifier.m
 *  D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\inremental.m
 *  D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\metrics.m
 *  D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\smal.m
 *  D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\updateTraining.m
 * </pre>
 * The {@link #dispose} method <b>must</b> be called on a <code>smalDetectorRemote</code> 
 * instance when it is no longer needed to ensure that native resources allocated by this 
 * class are properly freed, and the server-side proxy is unexported.  (Failure to call 
 * dispose may result in server-side threads not being properly shut down, which often 
 * appears as a hang.)  
 *
 * This interface is designed to be used together with 
 * <code>com.mathworks.toolbox.javabuilder.remoting.RemoteProxy</code> to automatically 
 * generate RMI server proxy objects for instances of smal.smalDetector.
 */
public interface smalDetectorRemote extends Poolable
{
    /**
     * Provides the standard interface for calling the <code>classifier</code> M-function 
     * with 1 input argument.  
     *
     * Input arguments to standard interface methods may be passed as sub-classes of 
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of any 
     * supported Java type (i.e. scalars and multidimensional arrays of any numeric, 
     * boolean, or character type, or String). Arguments passed as Java types are 
     * converted to MATLAB arrays according to default conversion rules.
     *
     * All inputs to this method must implement either Serializable (pass-by-value) or 
     * Remote (pass-by-reference) as per the RMI specification.
     *
     * M-documentation as provided by the author of the M function:
     * <pre>
     * %CLASSIFIER Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     *
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     *
     * @return Array of length nargout containing the function outputs. Outputs are 
     * returned as sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>. 
     * Each output array should be freed by calling its <code>dispose()</code> method.
     *
     * @throws java.jmi.RemoteException An error has occurred during the function call or 
     * in communication with the server.
     */
    public Object[] classifier(int nargout, Object... rhs) throws RemoteException;
    /**
     * Provides the standard interface for calling the <code>inremental</code> M-function 
     * with 1 input argument.  
     *
     * Input arguments to standard interface methods may be passed as sub-classes of 
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of any 
     * supported Java type (i.e. scalars and multidimensional arrays of any numeric, 
     * boolean, or character type, or String). Arguments passed as Java types are 
     * converted to MATLAB arrays according to default conversion rules.
     *
     * All inputs to this method must implement either Serializable (pass-by-value) or 
     * Remote (pass-by-reference) as per the RMI specification.
     *
     * M-documentation as provided by the author of the M function:
     * <pre>
     * %
     * % setenv('JAVA_HOME','C:\\Program Files\\Java\\jdk1.7.0_17\\')
     * % 
     * % Implementation of Incremental Learning of k-approximate eigenvectors.
     * % Demo computes the eigenfunctions and eigenvalues from training data
     * % and compute the training eigenvector. From this eigenvectors, demo
     * % computes the eigenfunctions and eigenvectors of test data by
     * % interpolating them.
     * % For efficient reasons, demo compute the eigenvectos from test data
     * % in batches (1000 items/batch).
     * %
     * % Demo also runs two different variant of learning model methods:
     * % 1. Linear SVM.
     * % 2. Smooth Function
     * %
     * % The code is ready to run for flickr2013 (included ulr file) and twitter2013 
     * datasets.
     * % You can download the datasets from
     * % 1. flickr2013: 
     * http://www.socialsensor.eu/datasets/mm-concept-detection-dataset-2013/mm-concept-detection-datasets.zip
     * % 2. twitter2013: 
     * http://www.socialsensor.eu/datasets/mm-concept-detection-dataset-2013/mm-concept-detection-twitter2013-images.zip
     * %      password: socialsensor
     * %
     * % It is tested in ACM Yahoo Grand Challenge 2013 competition
     * %
     * % SmaL uses SIFT/RGB-SIFT VLAD feature aggregation method (and with spatial 
     * pyramids)
     * % and PCA for image representation.
     * % The implementation of SmaL approach is general and can be applied to any data.
     * %
     * % Version 1.0. Eleni Mantziou. 6/1/13.
     * </pre>
     *
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     *
     * @return Array of length nargout containing the function outputs. Outputs are 
     * returned as sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>. 
     * Each output array should be freed by calling its <code>dispose()</code> method.
     *
     * @throws java.jmi.RemoteException An error has occurred during the function call or 
     * in communication with the server.
     */
    public Object[] inremental(int nargout, Object... rhs) throws RemoteException;
    /**
     * Provides the standard interface for calling the <code>metrics</code> M-function 
     * with 2 input arguments.  
     *
     * Input arguments to standard interface methods may be passed as sub-classes of 
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of any 
     * supported Java type (i.e. scalars and multidimensional arrays of any numeric, 
     * boolean, or character type, or String). Arguments passed as Java types are 
     * converted to MATLAB arrays according to default conversion rules.
     *
     * All inputs to this method must implement either Serializable (pass-by-value) or 
     * Remote (pass-by-reference) as per the RMI specification.
     *
     * M-documentation as provided by the author of the M function:
     * <pre>
     * %METRICS Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     *
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     *
     * @return Array of length nargout containing the function outputs. Outputs are 
     * returned as sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>. 
     * Each output array should be freed by calling its <code>dispose()</code> method.
     *
     * @throws java.jmi.RemoteException An error has occurred during the function call or 
     * in communication with the server.
     */
    public Object[] metrics(int nargout, Object... rhs) throws RemoteException;
    /**
     * Provides the standard interface for calling the <code>smal</code> M-function with 
     * 1 input argument.  
     *
     * Input arguments to standard interface methods may be passed as sub-classes of 
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of any 
     * supported Java type (i.e. scalars and multidimensional arrays of any numeric, 
     * boolean, or character type, or String). Arguments passed as Java types are 
     * converted to MATLAB arrays according to default conversion rules.
     *
     * All inputs to this method must implement either Serializable (pass-by-value) or 
     * Remote (pass-by-reference) as per the RMI specification.
     *
     * M-documentation as provided by the author of the M function:
     * <pre>
     * %SMALFUNC Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     *
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     *
     * @return Array of length nargout containing the function outputs. Outputs are 
     * returned as sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>. 
     * Each output array should be freed by calling its <code>dispose()</code> method.
     *
     * @throws java.jmi.RemoteException An error has occurred during the function call or 
     * in communication with the server.
     */
    public Object[] smal(int nargout, Object... rhs) throws RemoteException;
    /**
     * Provides the standard interface for calling the <code>updateTraining</code> 
     * M-function with 1 input argument.  
     *
     * Input arguments to standard interface methods may be passed as sub-classes of 
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of any 
     * supported Java type (i.e. scalars and multidimensional arrays of any numeric, 
     * boolean, or character type, or String). Arguments passed as Java types are 
     * converted to MATLAB arrays according to default conversion rules.
     *
     * All inputs to this method must implement either Serializable (pass-by-value) or 
     * Remote (pass-by-reference) as per the RMI specification.
     *
     * M-documentation as provided by the author of the M function:
     * <pre>
     * %UPDATETRAINING Summary of this function goes here
     * %   Detailed explanation goes here
     * %
     * %  setenv('JAVA_HOME','C:\\Program Files\\Java\\jdk1.7.0_17\\')
     * %
     * %------------------------------------------------------------------
     * % ======Find bins, g and eigenvcalues in train set=================
     * </pre>
     *
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     *
     * @return Array of length nargout containing the function outputs. Outputs are 
     * returned as sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>. 
     * Each output array should be freed by calling its <code>dispose()</code> method.
     *
     * @throws java.jmi.RemoteException An error has occurred during the function call or 
     * in communication with the server.
     */
    public Object[] updateTraining(int nargout, Object... rhs) throws RemoteException;
  
    /** Frees native resources associated with the remote server object */
    void dispose() throws RemoteException;
}
