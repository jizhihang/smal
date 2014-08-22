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

import com.mathworks.toolbox.javabuilder.*;
import com.mathworks.toolbox.javabuilder.internal.*;
import java.util.*;

/**
 * The <code>smalDetector</code> class provides a Java interface to the M-functions
 * from the files:
 * <pre>
 *  D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\classifier.m
 *  D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\inremental.m
 *  D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\metrics.m
 *  D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\smal.m
 *  D:\\lena\\Codes\\MyCodes\\smal\\smal\\matlab\\JavaFunctions\\updateTraining.m
 * </pre>
 * The {@link #dispose} method <b>must</b> be called on a <code>smalDetector</code> 
 * instance when it is no longer needed to ensure that native resources allocated by this 
 * class are properly freed.
 * @version 0.0
 */
public class smalDetector extends MWComponentInstance<smalDetector>
{
    /**
     * Tracks all instances of this class to ensure their dispose method is
     * called on shutdown.
     */
    private static final Set<Disposable> sInstances = new HashSet<Disposable>();

    /**
     * Maintains information used in calling the <code>classifier</code> M-function.
     */
    private static final MWFunctionSignature sClassifierSignature =
        new MWFunctionSignature(/* max outputs = */ 2,
                                /* has varargout = */ false,
                                /* function name = */ "classifier",
                                /* max inputs = */ 1,
                                /* has varargin = */ false);
    /**
     * Maintains information used in calling the <code>inremental</code> M-function.
     */
    private static final MWFunctionSignature sInrementalSignature =
        new MWFunctionSignature(/* max outputs = */ 1,
                                /* has varargout = */ false,
                                /* function name = */ "inremental",
                                /* max inputs = */ 1,
                                /* has varargin = */ false);
    /**
     * Maintains information used in calling the <code>metrics</code> M-function.
     */
    private static final MWFunctionSignature sMetricsSignature =
        new MWFunctionSignature(/* max outputs = */ 2,
                                /* has varargout = */ false,
                                /* function name = */ "metrics",
                                /* max inputs = */ 2,
                                /* has varargin = */ false);
    /**
     * Maintains information used in calling the <code>smal</code> M-function.
     */
    private static final MWFunctionSignature sSmalSignature =
        new MWFunctionSignature(/* max outputs = */ 1,
                                /* has varargout = */ false,
                                /* function name = */ "smal",
                                /* max inputs = */ 1,
                                /* has varargin = */ false);
    /**
     * Maintains information used in calling the <code>updateTraining</code> M-function.
     */
    private static final MWFunctionSignature sUpdateTrainingSignature =
        new MWFunctionSignature(/* max outputs = */ 5,
                                /* has varargout = */ false,
                                /* function name = */ "updateTraining",
                                /* max inputs = */ 1,
                                /* has varargin = */ false);

    /**
     * Shared initialization implementation - private
     */
    private smalDetector (final MWMCR mcr) throws MWException
    {
        super(mcr);
        // add this to sInstances
        synchronized(smalDetector.class) {
            sInstances.add(this);
        }
    }

    /**
     * Constructs a new instance of the <code>smalDetector</code> class.
     */
    public smalDetector() throws MWException
    {
        this(SmalMCRFactory.newInstance());
    }
    
    private static MWComponentOptions getPathToComponentOptions(String path)
    {
        MWComponentOptions options = new MWComponentOptions(new MWCtfExtractLocation(path),
                                                            new MWCtfDirectorySource(path));
        return options;
    }
    
    /**
     * @deprecated Please use the constructor {@link #smalDetector(MWComponentOptions componentOptions)}.
     * The <code>com.mathworks.toolbox.javabuilder.MWComponentOptions</code> class provides API to set the
     * path to the component.
     * @param pathToComponent Path to component directory.
     */
    public smalDetector(String pathToComponent) throws MWException
    {
        this(SmalMCRFactory.newInstance(getPathToComponentOptions(pathToComponent)));
    }
    
    /**
     * Constructs a new instance of the <code>smalDetector</code> class. Use this 
     * constructor to specify the options required to instantiate this component.  The 
     * options will be specific to the instance of this component being created.
     * @param componentOptions Options specific to the component.
     */
    public smalDetector(MWComponentOptions componentOptions) throws MWException
    {
        this(SmalMCRFactory.newInstance(componentOptions));
    }
    
    /** Frees native resources associated with this object */
    public void dispose()
    {
        try {
            super.dispose();
        } finally {
            synchronized(smalDetector.class) {
                sInstances.remove(this);
            }
        }
    }
  
    /**
     * Invokes the first m-function specified by MCC, with any arguments given on
     * the command line, and prints the result.
     */
    public static void main (String[] args)
    {
        try {
            MWMCR mcr = SmalMCRFactory.newInstance();
            mcr.runMain( sClassifierSignature, args);
            mcr.dispose();
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }
    
    /**
     * Calls dispose method for each outstanding instance of this class.
     */
    public static void disposeAllInstances()
    {
        synchronized(smalDetector.class) {
            for (Disposable i : sInstances) i.dispose();
            sInstances.clear();
        }
    }

    /**
     * Provides the interface for calling the <code>classifier</code> M-function 
     * where the first input, an instance of List, receives the output of the M-function and
     * the second input, also an instance of List, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %CLASSIFIER Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     * </p>
     * @param lhs List in which to return outputs. Number of outputs (nargout) is
     * determined by allocated size of this List. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs List containing inputs. Number of inputs (nargin) is determined
     * by the allocated size of this List. Input arguments may be passed as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or
     * as arrays of any supported Java type. Arguments passed as Java types are
     * converted to MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void classifier(List lhs, List rhs) throws MWException
    {
        fMCR.invoke(lhs, rhs, sClassifierSignature);
    }

    /**
     * Provides the interface for calling the <code>classifier</code> M-function 
     * where the first input, an Object array, receives the output of the M-function and
     * the second input, also an Object array, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %CLASSIFIER Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     * </p>
     * @param lhs array in which to return outputs. Number of outputs (nargout)
     * is determined by allocated size of this array. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs array containing inputs. Number of inputs (nargin) is
     * determined by the allocated size of this array. Input arguments may be
     * passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void classifier(Object[] lhs, Object[] rhs) throws MWException
    {
        fMCR.invoke(Arrays.asList(lhs), Arrays.asList(rhs), sClassifierSignature);
    }

    /**
     * Provides the standard interface for calling the <code>classifier</code>
     * M-function with 1 input argument.
     * Input arguments may be passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     *
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %CLASSIFIER Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     * </p>
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     * @return Array of length nargout containing the function outputs. Outputs
     * are returned as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>. Each output array
     * should be freed by calling its <code>dispose()</code> method.
     * @throws MWException An error has occurred during the function call.
     */
    public Object[] classifier(int nargout, Object... rhs) throws MWException
    {
        Object[] lhs = new Object[nargout];
        fMCR.invoke(Arrays.asList(lhs), 
                    MWMCR.getRhsCompat(rhs, sClassifierSignature), 
                    sClassifierSignature);
        return lhs;
    }
    /**
     * Provides the interface for calling the <code>inremental</code> M-function 
     * where the first input, an instance of List, receives the output of the M-function and
     * the second input, also an instance of List, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
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
     * </p>
     * @param lhs List in which to return outputs. Number of outputs (nargout) is
     * determined by allocated size of this List. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs List containing inputs. Number of inputs (nargin) is determined
     * by the allocated size of this List. Input arguments may be passed as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or
     * as arrays of any supported Java type. Arguments passed as Java types are
     * converted to MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void inremental(List lhs, List rhs) throws MWException
    {
        fMCR.invoke(lhs, rhs, sInrementalSignature);
    }

    /**
     * Provides the interface for calling the <code>inremental</code> M-function 
     * where the first input, an Object array, receives the output of the M-function and
     * the second input, also an Object array, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
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
     * </p>
     * @param lhs array in which to return outputs. Number of outputs (nargout)
     * is determined by allocated size of this array. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs array containing inputs. Number of inputs (nargin) is
     * determined by the allocated size of this array. Input arguments may be
     * passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void inremental(Object[] lhs, Object[] rhs) throws MWException
    {
        fMCR.invoke(Arrays.asList(lhs), Arrays.asList(rhs), sInrementalSignature);
    }

    /**
     * Provides the standard interface for calling the <code>inremental</code>
     * M-function with 1 input argument.
     * Input arguments may be passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     *
     * <p>M-documentation as provided by the author of the M function:
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
     * </p>
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     * @return Array of length nargout containing the function outputs. Outputs
     * are returned as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>. Each output array
     * should be freed by calling its <code>dispose()</code> method.
     * @throws MWException An error has occurred during the function call.
     */
    public Object[] inremental(int nargout, Object... rhs) throws MWException
    {
        Object[] lhs = new Object[nargout];
        fMCR.invoke(Arrays.asList(lhs), 
                    MWMCR.getRhsCompat(rhs, sInrementalSignature), 
                    sInrementalSignature);
        return lhs;
    }
    /**
     * Provides the interface for calling the <code>metrics</code> M-function 
     * where the first input, an instance of List, receives the output of the M-function and
     * the second input, also an instance of List, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %METRICS Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     * </p>
     * @param lhs List in which to return outputs. Number of outputs (nargout) is
     * determined by allocated size of this List. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs List containing inputs. Number of inputs (nargin) is determined
     * by the allocated size of this List. Input arguments may be passed as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or
     * as arrays of any supported Java type. Arguments passed as Java types are
     * converted to MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void metrics(List lhs, List rhs) throws MWException
    {
        fMCR.invoke(lhs, rhs, sMetricsSignature);
    }

    /**
     * Provides the interface for calling the <code>metrics</code> M-function 
     * where the first input, an Object array, receives the output of the M-function and
     * the second input, also an Object array, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %METRICS Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     * </p>
     * @param lhs array in which to return outputs. Number of outputs (nargout)
     * is determined by allocated size of this array. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs array containing inputs. Number of inputs (nargin) is
     * determined by the allocated size of this array. Input arguments may be
     * passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void metrics(Object[] lhs, Object[] rhs) throws MWException
    {
        fMCR.invoke(Arrays.asList(lhs), Arrays.asList(rhs), sMetricsSignature);
    }

    /**
     * Provides the standard interface for calling the <code>metrics</code>
     * M-function with 2 input arguments.
     * Input arguments may be passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     *
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %METRICS Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     * </p>
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     * @return Array of length nargout containing the function outputs. Outputs
     * are returned as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>. Each output array
     * should be freed by calling its <code>dispose()</code> method.
     * @throws MWException An error has occurred during the function call.
     */
    public Object[] metrics(int nargout, Object... rhs) throws MWException
    {
        Object[] lhs = new Object[nargout];
        fMCR.invoke(Arrays.asList(lhs), 
                    MWMCR.getRhsCompat(rhs, sMetricsSignature), 
                    sMetricsSignature);
        return lhs;
    }
    /**
     * Provides the interface for calling the <code>smal</code> M-function 
     * where the first input, an instance of List, receives the output of the M-function and
     * the second input, also an instance of List, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %SMALFUNC Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     * </p>
     * @param lhs List in which to return outputs. Number of outputs (nargout) is
     * determined by allocated size of this List. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs List containing inputs. Number of inputs (nargin) is determined
     * by the allocated size of this List. Input arguments may be passed as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or
     * as arrays of any supported Java type. Arguments passed as Java types are
     * converted to MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void smal(List lhs, List rhs) throws MWException
    {
        fMCR.invoke(lhs, rhs, sSmalSignature);
    }

    /**
     * Provides the interface for calling the <code>smal</code> M-function 
     * where the first input, an Object array, receives the output of the M-function and
     * the second input, also an Object array, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %SMALFUNC Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     * </p>
     * @param lhs array in which to return outputs. Number of outputs (nargout)
     * is determined by allocated size of this array. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs array containing inputs. Number of inputs (nargin) is
     * determined by the allocated size of this array. Input arguments may be
     * passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void smal(Object[] lhs, Object[] rhs) throws MWException
    {
        fMCR.invoke(Arrays.asList(lhs), Arrays.asList(rhs), sSmalSignature);
    }

    /**
     * Provides the standard interface for calling the <code>smal</code>
     * M-function with 1 input argument.
     * Input arguments may be passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     *
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %SMALFUNC Summary of this function goes here
     * %   Detailed explanation goes here
     * </pre>
     * </p>
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     * @return Array of length nargout containing the function outputs. Outputs
     * are returned as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>. Each output array
     * should be freed by calling its <code>dispose()</code> method.
     * @throws MWException An error has occurred during the function call.
     */
    public Object[] smal(int nargout, Object... rhs) throws MWException
    {
        Object[] lhs = new Object[nargout];
        fMCR.invoke(Arrays.asList(lhs), 
                    MWMCR.getRhsCompat(rhs, sSmalSignature), 
                    sSmalSignature);
        return lhs;
    }
    /**
     * Provides the interface for calling the <code>updateTraining</code> M-function 
     * where the first input, an instance of List, receives the output of the M-function and
     * the second input, also an instance of List, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %UPDATETRAINING Summary of this function goes here
     * %   Detailed explanation goes here
     * %
     * %  setenv('JAVA_HOME','C:\\Program Files\\Java\\jdk1.7.0_17\\')
     * %
     * %------------------------------------------------------------------
     * % ======Find bins, g and eigenvcalues in train set=================
     * </pre>
     * </p>
     * @param lhs List in which to return outputs. Number of outputs (nargout) is
     * determined by allocated size of this List. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs List containing inputs. Number of inputs (nargin) is determined
     * by the allocated size of this List. Input arguments may be passed as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or
     * as arrays of any supported Java type. Arguments passed as Java types are
     * converted to MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void updateTraining(List lhs, List rhs) throws MWException
    {
        fMCR.invoke(lhs, rhs, sUpdateTrainingSignature);
    }

    /**
     * Provides the interface for calling the <code>updateTraining</code> M-function 
     * where the first input, an Object array, receives the output of the M-function and
     * the second input, also an Object array, provides the input to the M-function.
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %UPDATETRAINING Summary of this function goes here
     * %   Detailed explanation goes here
     * %
     * %  setenv('JAVA_HOME','C:\\Program Files\\Java\\jdk1.7.0_17\\')
     * %
     * %------------------------------------------------------------------
     * % ======Find bins, g and eigenvcalues in train set=================
     * </pre>
     * </p>
     * @param lhs array in which to return outputs. Number of outputs (nargout)
     * is determined by allocated size of this array. Outputs are returned as
     * sub-classes of <code>com.mathworks.toolbox.javabuilder.MWArray</code>.
     * Each output array should be freed by calling its <code>dispose()</code>
     * method.
     *
     * @param rhs array containing inputs. Number of inputs (nargin) is
     * determined by the allocated size of this array. Input arguments may be
     * passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     * @throws MWException An error has occurred during the function call.
     */
    public void updateTraining(Object[] lhs, Object[] rhs) throws MWException
    {
        fMCR.invoke(Arrays.asList(lhs), Arrays.asList(rhs), sUpdateTrainingSignature);
    }

    /**
     * Provides the standard interface for calling the <code>updateTraining</code>
     * M-function with 1 input argument.
     * Input arguments may be passed as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>, or as arrays of
     * any supported Java type. Arguments passed as Java types are converted to
     * MATLAB arrays according to default conversion rules.
     *
     * <p>M-documentation as provided by the author of the M function:
     * <pre>
     * %UPDATETRAINING Summary of this function goes here
     * %   Detailed explanation goes here
     * %
     * %  setenv('JAVA_HOME','C:\\Program Files\\Java\\jdk1.7.0_17\\')
     * %
     * %------------------------------------------------------------------
     * % ======Find bins, g and eigenvcalues in train set=================
     * </pre>
     * </p>
     * @param nargout Number of outputs to return.
     * @param rhs The inputs to the M function.
     * @return Array of length nargout containing the function outputs. Outputs
     * are returned as sub-classes of
     * <code>com.mathworks.toolbox.javabuilder.MWArray</code>. Each output array
     * should be freed by calling its <code>dispose()</code> method.
     * @throws MWException An error has occurred during the function call.
     */
    public Object[] updateTraining(int nargout, Object... rhs) throws MWException
    {
        Object[] lhs = new Object[nargout];
        fMCR.invoke(Arrays.asList(lhs), 
                    MWMCR.getRhsCompat(rhs, sUpdateTrainingSignature), 
                    sUpdateTrainingSignature);
        return lhs;
    }
}
