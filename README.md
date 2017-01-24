<span class="ptmr7t-x-x-240">Object Tracking Using Kalman Filter</span>

<span class="ptmr7t-x-x-110">Shahin Khobahi</span> <a href="" id="x1-2r1"></a>

<span class="ptmrc7t-">I. I<span class="small-caps">n</span><span class="small-caps">t</span><span class="small-caps">r</span><span class="small-caps">o</span><span class="small-caps">d</span><span class="small-caps">u</span><span class="small-caps">c</span><span class="small-caps">t</span><span class="small-caps">i</span><span class="small-caps">o</span><span class="small-caps">n</span></span> <a href="" id="Q1-1-0"></a>

In this project, we are proposing an adaptive ﬁlter approach to track a moving object in a video. Currently, object tracking is an important issue in many applications such as video survelance, traﬃc management, video indexing, machine learning, artiﬁcial intelligence and many other related ﬁelds. As we will discuss in the following sections, moving object tracking can be interpreted as an estimation problem. Kalman ﬁlter is a powerful algorithm that can be used in the state estimation problems and that is the reason we used this method to estimate and predict the position of a moving object. In the ﬁrst stage of this project we use the background subtraction method to detect the moving object in the video and then we use the Kalman ﬁlter ro predict and estimate the next state of the object. <a href="" id="x1-3r2"></a>

<span class="ptmrc7t-">II. P<span class="small-caps">r</span><span class="small-caps">o</span><span class="small-caps">b</span><span class="small-caps">l</span><span class="small-caps">e</span><span class="small-caps">m</span> F<span class="small-caps">o</span><span class="small-caps">r</span><span class="small-caps">m</span><span class="small-caps">u</span><span class="small-caps">l</span><span class="small-caps">a</span><span class="small-caps">t</span><span class="small-caps">i</span><span class="small-caps">o</span><span class="small-caps">n</span></span> <a href="" id="Q1-1-0"></a>

<a href="" id="x1-4r1"></a>

<span class="ptmri7t-">A. Object Detection Using Background Subtraction</span> <a href="" id="Q1-1-0"></a>

A video is composed of a series of frames each which can be considered as a 2D signal. So, a video can be seen as a two-dimensional (2D) signal through time. Moreover, there are two types of objects in a video: <span class="ptmri7t-">steady and moving objects</span>. Steady objects do not change from frame to frame and can be considered as the background scene. The goal is to detect a moving objects from the steady ones. First let us provide an example: consider that you are looking at a wall and suddenly a birdy ﬂy over this wall. The steady object in this scene is the wall and the moving object is the birds. The bird is in fact disturbing your observation of the wall(background), so in the context of signal processing, this bird(moving object) can be seen as a noise to that background. In other words, in a video, a moving object is like a noise to the background scene which is a ﬁxed signal, and this moving object is adding noise to our observation of that background. Consequently, each frame of the video can be interpreted as a noisy observation of the background. Therefore, the problem is just simply the noise detection in a signal. The following model can be used for our problem:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-5r1"></a>
<img src="document0x.png" alt="y = x + v " class="math-display" /></td>
<td>(1)</td>
</tr>
</tbody>
</table>

Where <span class="cmmi-10">y </span>is our noisy measurement of <span class="cmmi-10">x </span>(background signal), and <span class="cmmi-10">v </span>denotes the disturbance which in fact is our moving object disturbing that background signal <span class="cmmi-10">x</span>. As it was mentioned earlier, we need to extract the noise <span class="cmmi-10">v </span>from our noisy signal <span class="cmmi-10">y </span>(the video). Each frame of the video is a noisy realization of the signal <span class="cmmi-10">y </span>and we refer to the i-th frame of the video as <span class="cmmi-10">u</span><sub><span class="cmmi-7">i</span></sub>. Further we assume that the video has <span class="cmmi-10">N </span>frames. Our approach of extracting the noise from the observations <span class="cmmi-10">u</span><sub><span class="cmmi-7">i</span></sub> is to ﬁrst obtain an <span class="ptmri7t-">estimation </span>of the background signal <img src="document1x.png" alt="ˆx" class="circ" />, then we subtract each observation <span class="cmmi-10">u</span><sub><span class="cmmi-7">i</span></sub> from the estimated signal <img src="document2x.png" alt="ˆx" class="circ" /> to obtain an estimation of the noise at each frame:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-6r2"></a>
<img src="document3x.png" alt="ˆvi = ui − xˆ " class="math-display" /></td>
<td>(2)</td>
</tr>
</tbody>
</table>

Given two deterministic random variables <span class="cmsy-10">{</span><span class="cmbx-10">x</span><span class="cmmi-10">,</span><span class="cmbx-10">y</span><span class="cmsy-10">}</span>, we deﬁne the least-mean-squares estimator (l.m.s.e) of <span class="cmmi-10">x </span>given <span class="cmmi-10">y </span>as the conditional expectation of <span class="cmbx-10">x </span>given <span class="cmbx-10">y</span>:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-7r3"></a>
<img src="document4x.png" alt="xˆ= E (x |y) = E[x|u0,u2,...,uN −1] " class="math-display" /></td>
<td>(3)</td>
</tr>
</tbody>
</table>

For simplicity, we assume that we model <span class="cmmi-10">x </span>as an unknown constant instead of a random variable. Further we assume that we are given <span class="cmmi-10">N </span>frames of the video and that is all the information we have. Now, we model our problem as follows:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-8r4"></a>
<img src="document5x.png" alt="y(i) = x + v(i), i = 0,1,...,N − 1 " class="math-display" /></td>
<td>(4)</td>
</tr>
</tbody>
</table>

and we deﬁne the column vector <span class="dsrom-10">𝟙</span> <span class="cmr-10">= \[1</span><span class="cmmi-10">,</span><span class="cmr-10">1</span><span class="cmmi-10">,</span><span class="cmmi-10">…</span><span class="cmmi-10">,</span><span class="cmr-10">1\]</span><sup><span class="cmmi-7">T</span></sup>. Then,

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-9r5"></a>
<img src="document6x.png" alt="y = 𝟙x +v " class="math-display" /></td>
<td>(5)</td>
</tr>
</tbody>
</table>

if this is the case, according to Gauss-Markov theorem, the optimal linear estimator (m.v.u.e) of <span class="cmmi-10">x </span>is:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-10r6"></a>
<img src="document7x.png" alt=" 1 N∑−1 1 N∑−1 ˆxmvue = -- y(i) =-- ui N i=0 N i=0 " class="math-display" /></td>
<td>(6)</td>
</tr>
</tbody>
</table>

Namely, (6) means that the optimal linear estimator of x given <span class="cmsy-10">{</span><span class="cmbx-10">y</span><span class="cmr-10">(</span><span class="cmmi-10">i</span><span class="cmr-10">)</span><span class="cmsy-10">}</span>, is simply the mean of the samples(measurements). So, in order to obtain an estimation of the background of the video, we take the average of all frames and store it as the background scene. Fig. 1 illustrates 4 frames of a sample video, these samples are in fact 4 noisy measurements of our signal, and that yellow ball which we are trying to track acts as the disturbance to the background of the video(the door and the wall). Fig. 2 provides the background scene that is the result of averaging over all of the frames. Please note that in this project we are assuming that the background does not change, so sample-mean estimator is a good estimation of the background. However, in the case of real-time tracking where the background is not changing, one can feed the average estimator as the frames arrives; evidently, in this case, estimation improves with time.

Now that we obtained <img src="document8x.png" alt="ˆx" class="circ" />, we can extract the noise from the signal(video) by subtracting each frame from the background. Fig. 3 provides four realization of the noise(moving object) at diﬀerent frames. Due to the fact that in our problem we do not care about the energy of the noise - the gray level of an image(pixels) is proportional to the energy or the amount of information it contains (entropy of the image) - we can use <span class="ptmri7t-">one-bit Compressed Sensing </span>method to store the noise. That is, we use the following model to store the noise :

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-11r7"></a>
<img src="document9x.png" alt="zi = sgn(vi − τi), i = 0,1,...,N − 1 " class="math-display" /></td>
<td>(7)</td>
</tr>
</tbody>
</table>

Where <span class="cmbx-10">z</span><sub><span class="cmbx-7">i</span></sub> denotes the quantized measurement of <span class="cmbx-10">v</span><sub><span class="cmbx-7">i</span></sub> with respect to the threshold <span class="cmmi-10">τ</span><sub><span class="cmmi-7">i</span></sub>. Namely, instead of saving the real value of the measurement <span class="cmmi-10">v</span><sub><span class="cmmi-7">i</span></sub>, we only save the sign of it with respect to the deﬁned threshold <span class="cmmi-10">τ</span><sub><span class="cmmi-7">i</span></sub> at that measurement. In practice, one may use an <span class="ptmri7t-">adaptive </span>threshold but in our application we use a ﬁxed threshold at all of the measurements. Also, it is worth to mention that in the 1-bit compressed sensing model (7) we lose all of the information about the magnitude of <span class="cmbx-10">v</span><sub><span class="cmbx-7">i</span></sub> but as we mentioned earlier we do not care about the energy of the noise, so this model can be used to store the measurements and improve the speed of the tracking process and also it lowers the dimension of the calculations(an image typically has the intensity information of the colors: Red, Green, and Blue and after quantizing the measurements based on (7) we only has one dimension which is known as <span class="ptmri7t-">binary image</span>).
Fig. 4, illustrates one estimation of the noise after quantization. It can be observed that we have an anomaly at the bottom right corner of the Fig. 4, which emphesized the fact that this is not an exact realization of the noise(moving object) but instead it is an estimation of the noise and is prone to some errors.
Now that we estimated the moving object, we can easily ﬁnd the center of the object by inspecting the binary image of each frame and ﬁnd the area that contains more 1 and choose the larger area as the object. Then we can estimate the center of the area, and store it as the position of the moving object at each frame. Eventually, in Fig. 5, you can see that we detected the moving object at each frame. The yellow circle denotes our detection.

------------------------------------------------------------------------

<img src="document10x.png" alt="PIC" class="graphics" /> <a href="" id="x1-12r1"></a> <span class="ptmr7t-x-x-80">Fig.</span><span class="ptmr7t-x-x-80"> 1.</span><span class="ptmr7t-x-x-80"> </span><span class="ptmr7t-x-x-80"> Four sample frames of the video. In other words, these are four noisy measurements of the background (which is a 2D signal).</span>

------------------------------------------------------------------------

------------------------------------------------------------------------

<img src="document11x.png" alt="PIC" class="graphics" /> <a href="" id="x1-13r2"></a> <span class="ptmr7t-x-x-80">Fig.</span><span class="ptmr7t-x-x-80"> 2.</span><span class="ptmr7t-x-x-80"> </span><span class="ptmr7t-x-x-80"> An estimation of the background signal resulted from averaging over all frames.</span>

------------------------------------------------------------------------

------------------------------------------------------------------------

<img src="document12x.png" alt="PIC" class="graphics" /> <a href="" id="x1-14r3"></a> <span class="ptmr7t-x-x-80">Fig.</span><span class="ptmr7t-x-x-80"> 3.</span><span class="ptmr7t-x-x-80"> </span><span class="ptmr7t-x-x-80"> Four realizations of the noise (moving object) at diﬀerent frames.</span>

------------------------------------------------------------------------

------------------------------------------------------------------------

<img src="document13x.png" alt="PIC" class="graphics" /> <a href="" id="x1-15r4"></a> <span class="ptmr7t-x-x-80">Fig.</span><span class="ptmr7t-x-x-80"> 4.</span><span class="ptmr7t-x-x-80"> </span><span class="ptmr7t-x-x-80"> One realization of the noise after quantization.</span>

------------------------------------------------------------------------

------------------------------------------------------------------------

<img src="document14x.png" alt="PIC" class="graphics" /> <a href="" id="x1-16r5"></a> <span class="ptmr7t-x-x-80">Fig.</span><span class="ptmr7t-x-x-80"> 5.</span><span class="ptmr7t-x-x-80"> </span><span class="ptmr7t-x-x-80"> Four sample frames of the video. In other words, these are four noisy measurements of the background (which is a 2D signal).</span>

------------------------------------------------------------------------

<a href="" id="x1-17r2"></a>

<span class="ptmri7t-">B. Kalman Filter</span> <a href="" id="Q1-1-5"></a>

In this section we describe the formulation and system model for Kalman ﬁlter.
Intutitively, Kalman ﬁlter takes the current state of your system, and makes a prediction based on the current state and current uncertainty of our measurements, and make a prediction for the next state of the system with anuncertainty. Then, it compares its prediction with the received input and correct it self upon the error.
First we need to deﬁne our state for the Kalman ﬁlter. We want to predict the position of a moving object based on the current information of the object. For simplicity we assume a constant velocity model for our problem. The dynamics of a moving object in one-dimension can be described as follows:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-18r8"></a>
<img src="document15x.png" alt="xt = 1aT 2 + vt−1T + xt−1 2 " class="math-display" /></td>
<td>(8)</td>
</tr>
</tbody>
</table>

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-19r9"></a>
<img src="document16x.png" alt="vt = aT + vt−1 " class="math-display" /></td>
<td>(9)</td>
</tr>
</tbody>
</table>

Where <span class="cmmi-10">x</span><sub><span class="cmmi-7">t</span></sub> and <span class="cmmi-10">v</span><sub><span class="cmmi-7">t</span></sub> denotes the position and velocity at time <span class="cmmi-10">t</span>, and <span class="cmmi-10">a </span>denotes the acceleration. So, the dynamics of a moving object in one-dimension can be modeled by the position and the ﬁrst derivation of it. Without losing the generality, we can extend the one-dimensional case to a 2D object and conclude that the dynamics of a two-dimensional object can be described by <span class="cmmi-10">x</span>, <span class="cmmi-10">y</span>, <span class="cmmi-10">ẋ</span>, and <span class="cmmi-10">ẏ</span>.
We deﬁne the state <span class="cmmi-10">X</span><sub><span class="cmmi-7">t</span></sub> with the following variables of interest:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-20r10"></a>
<img src="document17x.png" alt=" ⌊ ⌋ xt ||yt|| Xt = ⌈x˙t⌉ y˙t " class="math-display" /></td>
<td>(10)</td>
</tr>
</tbody>
</table>

Next, we need to see what is the expected behaviour of our variables when we are going from one state to another. Based on Eq. (8) and (9), we deﬁne the following behaviour for the system variables:

<span class="cmmi-10">x</span><sub><span class="cmmi-7">t</span></sub> <span class="cmr-10">= </span><span class="cmmi-10">x</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub> <span class="cmr-10">+</span> <span class="cmmi-10">ẋ</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub><span class="cmmi-10">T </span><span class="cmr-10">+</span> <img src="document18x.png" alt="1 2" class="frac" /><span class="cmmi-10">aT</span><sup><span class="cmr-7">2</span></sup>

<span class="cmmi-10">y</span><sub><span class="cmmi-7">t</span></sub> <span class="cmr-10">= </span><span class="cmmi-10">y</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub> <span class="cmr-10">+</span> <span class="cmmi-10">ẏ</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub><span class="cmmi-10">T </span><span class="cmr-10">+</span> <img src="document19x.png" alt="1 2" class="frac" /><span class="cmmi-10">aT</span><sup><span class="cmr-7">2</span></sup>

<span class="cmmi-10">ẋ</span><sub><span class="cmmi-7">t</span></sub> <span class="cmr-10">=</span> <span class="cmmi-10">ẋ</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub><span class="cmmi-10">T </span><span class="cmr-10">+ </span><span class="cmmi-10">aT</span>

<span class="cmmi-10">ẏ</span><sub><span class="cmmi-7">t</span></sub> <span class="cmr-10">=</span> <span class="cmmi-10">ẏ</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub><span class="cmmi-10">T </span><span class="cmr-10">+ </span><span class="cmmi-10">aT</span>

So, the following model can be used to deﬁne the state transition:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-21r11"></a>
<img src="document20x.png" alt="⌊xt⌋ ⌊1 0 T 0⌋ ⌊xt−1⌋ ⌊1T2⌋ |yt| |0 1 0 T| |yt−1| |21T2| |⌈x˙t|⌉ = |⌈0 0 1 0|⌉ |⌈x˙t−1|⌉ + |⌈2T |⌉ .a + Wt −1 y˙t 0 0 0 1 y˙t−1 T " class="math-display" /></td>
<td>(11)</td>
</tr>
</tbody>
</table>

We can formulate (11) as follows:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-22r12"></a>
<img src="document21x.png" alt="Xt = AXt−1 + But−1 " class="math-display" /></td>
<td>(12)</td>
</tr>
</tbody>
</table>

Where <span class="cmmi-10">Bu</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub> can be seen as the noise(or external force on the acceleration).
In this project, we are observing the position of the moving object. Therefore, we deﬁne the following measurement matrix <span class="cmmi-10">H</span>:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-23r13"></a>
<img src="document22x.png" alt=" [1 0 0 0] H = 0 1 0 0 " class="math-display" /></td>
<td>(13)</td>
</tr>
</tbody>
</table>

The measurement matrix is:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-24r14"></a>
<img src="document23x.png" alt=" ⌊ xt⌋ [xt] [1 0 0 0]| yt| yt = 0 1 0 0 |⌈ ˙xt|⌉ + Vt ˙yt " class="math-display" /></td>
<td>(14)</td>
</tr>
</tbody>
</table>

Where <span class="cmbx-10">V </span><span class="cmr-10">= \[</span><span class="cmsy-10">𝒩</span><span class="cmr-10">(0</span><span class="cmmi-10">,σ</span><sub><span class="cmr-7">1</span></sub><sup><span class="cmr-7">2</span></sup><span class="cmr-10">)</span><span class="cmmi-10">,</span><span class="cmsy-10">𝒩</span><span class="cmr-10">(0</span><span class="cmmi-10">,σ</span><sub><span class="cmr-7">2</span></sub><sup><span class="cmr-7">2</span></sup><span class="cmr-10">)\]</span><sup><span class="cmmi-7">T</span></sup> is the measurement noise. Basically, Kalman ﬁlter has three noise covariance matrices:

-   <span class="ptmb7t-">Dynamic Noise</span>: During transition from one state to another, the system can be disturbed by an external force and add noise to the system. An external force can be modeled as a disturbance to the object acceleration in our problem. It contributes to the prediction of the next error covarinace matrix.
-   <span class="ptmb7t-">Measurement Noise</span>: All of our sensors are prone to noise and consequently will lead to a corruption of our measurements. We refer to this disturbance as the Measurement Noise.
-   <span class="ptmb7t-">Covariance of State Variables</span>

Assuming that the state variables are independent, we initialize the covariance matrix of state variables as follows. Please note that we can also consider this matrix as <span class="ptmri7t-">posteriori </span>error covariance matrix.

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-25r15"></a>
<img src="document24x.png" alt=" ⌊σ2 0 0 0 ⌋ | x0 σ2 0 0 | St = |⌈ 0 y0 σ2 0 |⌉ 0 0 ˙x0 σ2 ˙y " class="math-display" /></td>
<td>(15)</td>
</tr>
</tbody>
</table>

Also, we further assume that the measurement noises are independent, then the covariance matrix of <span class="cmbx-10">V </span>can be described as:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-26r16"></a>
<img src="document25x.png" alt=" [σ2 0] cov(V ) = R = 10 σ2 2 " class="math-display" /></td>
<td>(16)</td>
</tr>
</tbody>
</table>

Finally we need to deﬁne the covariance matrix of dynamic noise. As it was described earlier, this noise represents the disturbance during transition from one state to another. It can be written as:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-27r17"></a>
<img src="document26x.png" alt=" ⌊ σ2 0 σ 0⌋ | 0x σ2 x0˙x σ | Q = |⌈σ 0y σ2 y0˙y|⌉ x0x˙ σ x0˙ σ2 y˙y ˙y " class="math-display" /></td>
<td>(17)</td>
</tr>
</tbody>
</table>

From (11), we can deﬁne <span class="cmmi-10">Q </span>as:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-28r18"></a>
<img src="document27x.png" alt=" ⌊1 4 1 3 ⌋ |4T 104 2T 10 3| Q = |⌈10 3 4T 02 2T |⌉ 2T 103 T 02 0 2T 0 T " class="math-display" /></td>
<td>(18)</td>
</tr>
</tbody>
</table>

We assume that our original tracker (section II.a) is used as the input to the Kalman ﬁlter. We deﬁne the input vector as:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-29r19"></a>
<img src="document28x.png" alt=" [ˆxt] Yt = ˆyt " class="math-display" /></td>
<td>(19)</td>
</tr>
</tbody>
</table>

We deﬁned all of the required matrices for Kalman ﬁlter. Now we can use the Kalman ﬁlter based on the following algorithm to predict the position of the moving object based on our original tracker (section II.a) as the input to the ﬁlter. Kalman ﬁlter, has two stages: <span class="ptmri7t-">prediction </span>and <span class="ptmri7t-">correction </span>:

|                                                                       |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |     |     |
|-----------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----|-----|
| <span class="cmmi-10">Prediction </span><span class="cmr-10">:</span> |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |     |     |
|                                                                       | <span class="cmmi-10">X</span><sub><span class="cmmi-7">t</span></sub> <span class="cmr-10">= </span><span class="cmmi-10">AX</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub> <span class="cmr-10">+ </span><span class="cmmi-10">Bu</span>                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |     |     |
|                                                                       | <span class="cmmi-10">S</span><sub><span class="cmmi-7">t</span></sub> <span class="cmr-10">= </span><span class="cmmi-10">AS</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub><span class="cmmi-10">A</span><sup><span class="cmmi-7">T</span></sup> <span class="cmr-10">+ </span><span class="cmmi-10">Q</span>                                                                                                                                                                                                                                                                                                                                                                                              |     |     |
| <span class="cmmi-10">Correction </span><span class="cmr-10">:</span> |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |     |     |
|                                                                       | <span class="cmmi-10">K</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub> <span class="cmr-10">= </span><span class="cmmi-10">S</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub><span class="cmmi-10">H</span><sup><span class="cmmi-7">T</span></sup><span class="cmr-10">(</span><span class="cmmi-10">HS</span> <sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub><span class="cmmi-10">H</span><sup><span class="cmmi-7">T</span></sup> <span class="cmr-10">+ </span><span class="cmmi-10">R</span><span class="cmr-10">)</span><sup><span class="cmsy-7">−</span><span class="cmr-7">1</span></sup> |     |     |
|                                                                       | <span class="cmmi-10">X</span><sub><span class="cmmi-7">t</span><span class="cmr-7">+1</span></sub> <span class="cmr-10">= </span><span class="cmmi-10">X</span><sub><span class="cmmi-7">t</span></sub> <span class="cmr-10">+ </span><span class="cmmi-10">K</span><sub><span class="cmmi-7">t</span><span class="cmsy-7">−</span><span class="cmr-7">1</span></sub><span class="cmr-10">(</span><span class="cmmi-10">Y</span> <sub><span class="cmmi-7">t</span></sub> <span class="cmsy-10">− </span><span class="cmmi-10">HX</span><sub><span class="cmmi-7">t</span></sub><span class="cmr-10">)</span>                                                                                                                                                        |     |     |
|                                                                       | <span class="cmmi-10">S</span><sub><span class="cmmi-7">t</span><span class="cmr-7">+1</span></sub> <span class="cmr-10">= (</span><span class="cmmi-10">I </span><span class="cmsy-10">− </span><span class="cmmi-10">K</span><sub><span class="cmmi-7">t</span></sub><span class="cmmi-10">H</span><span class="cmr-10">)</span><span class="cmmi-10">St</span>                                                                                                                                                                                                                                                                                                                                                                                                     |     |     |

<a href="" id="x1-30r3"></a>

<span class="ptmrc7t-">III. R<span class="small-caps">e</span><span class="small-caps">s</span><span class="small-caps">u</span><span class="small-caps">l</span><span class="small-caps">t</span><span class="small-caps">s</span></span> <a href="" id="Q1-1-5"></a>

In order to observe the behaviour of Kalman ﬁlter under diﬀerent circumstances, we considered three diﬀerent cases to examine the Kalman ﬁlter in object tracking. In the following subsections, we examine each of these cases. <a href="" id="x1-31r1"></a>

<span class="ptmri7t-">A. Scenario 1: Prediction</span> <a href="" id="Q1-1-5"></a>

The ﬁrst scenario is the case that we are sensing the position of the object every 3 frames and we want to have a good prediction of the position of moving object based on these samples. Fig. 6, illustrates the result in four diﬀerent frames. The yellow circle is our main tracker(which is used as the input to the Kalman ﬁlter every 3 frames) and the black circle is the prediction of Kalman ﬁlter. It can be observed that the Kalman ﬁlter is tracking the moving object with a very good accuracy.

------------------------------------------------------------------------

<img src="document29x.png" alt="PIC" class="graphics" /> <a href="" id="x1-32r6"></a> <span class="ptmr7t-x-x-80">Fig.</span><span class="ptmr7t-x-x-80"> 6.</span><span class="ptmr7t-x-x-80"> </span><span class="ptmr7t-x-x-80"> Scenario 1 in which the Kalman ﬁlter tracks the moving object when it is feeded every three samples.</span>

------------------------------------------------------------------------

<a href="" id="x1-33r2"></a>

<span class="ptmri7t-">B. Scenario 2: Prediction In The Presence of Noise</span> <a href="" id="Q1-1-6"></a>

In this scenario, we add a large noise to the input of the Kalman ﬁlter. It turns out that the Kalman ﬁlter is more robust to the noise than the original tracker. So, if we have our measurements aren corrupted by noise, one can use the Kalman ﬁlter to obtain a better estimation than each of the sensors (<span class="ptmri7t-">data fusion</span>) because this algorithm is an adaptive ﬁlter and is more robust to the noise than each of the sensors. Fig. 7, illustrates this scenario. It can be seen that, the yellow circle is jumping around and is far from the object. However, the Kalman ﬁlter has a better estimation of the position. Please note that, a low gain will smooth out the noise but also lowers the speed of Kalman ﬁlter (it will detect the changes more slowly).

------------------------------------------------------------------------

<img src="document30x.png" alt="PIC" class="graphics" /> <a href="" id="x1-34r7"></a> <span class="ptmr7t-x-x-80">Fig.</span><span class="ptmr7t-x-x-80"> 7.</span><span class="ptmr7t-x-x-80"> </span><span class="ptmr7t-x-x-80"> Scenario 2 in which the Kalman ﬁlter tracks the moving object in the presence of a large noise.</span>

------------------------------------------------------------------------

<a href="" id="x1-35r3"></a>

<span class="ptmri7t-">C. Scenario 3: Blind Prediction</span> <a href="" id="Q1-1-7"></a>

In this case, we let the Kalman ﬁlter to learn for half of the frames and then we did not update the input for the ﬁlter. In (10) we deﬁned the dynamic of the system for the constant velocity object. That is, we are not capturing the acceleration of the system. So, we should expect that the Kalman ﬁlter can not track the trajectory of the ball because the object is under the gravity and has a negative vertical acceleration. If we want to track the trajectory of the without the input, we must use a more complex system model as follows:

<table>
<colgroup>
<col width="50%" />
<col width="50%" />
</colgroup>
<tbody>
<tr class="odd">
<td><a href="" id="x1-36r20"></a>
<img src="document31x.png" alt=" ⌊x ⌋ | y| ||x˙|| X = || ˙y|| |⌈x¨|⌉ ¨y " class="math-display" /></td>
<td>(20)</td>
</tr>
</tbody>
</table>

Fig. 8 provides the result of this scenario. As you can see, Kalman ﬁlter is not able to track the moving object after cutting the input and it tracks a linear path after that.

------------------------------------------------------------------------

<img src="document32x.png" alt="PIC" class="graphics" /> <a href="" id="x1-37r8"></a> <span class="ptmr7t-x-x-80">Fig.</span><span class="ptmr7t-x-x-80"> 8.</span><span class="ptmr7t-x-x-80"> </span><span class="ptmr7t-x-x-80"> Scenario 3 in which the Kalman ﬁlter blindly track the moving object.</span>

------------------------------------------------------------------------

<a href="" id="x1-38r4"></a>

<span class="ptmrc7t-">IV. C<span class="small-caps">o</span><span class="small-caps">n</span><span class="small-caps">c</span><span class="small-caps">l</span><span class="small-caps">u</span><span class="small-caps">s</span><span class="small-caps">i</span><span class="small-caps">o</span><span class="small-caps">n</span></span> <a href="" id="Q1-1-8"></a>

In this project we designed a Kalman ﬁlter to track a moving object in a video. In fact, as it was mentioned earlier, a moving object in a video can be seen as a noise to the background scene. So, this project was simply a noise detection based on Kalman ﬁlter. The same approach can be used to estimate and cancel out the noise of other signals. As we saw in the scenario 1 and 2, Kalman ﬁlter can be used whenever we need to predict the next state of a system based on some noisy measurements. Also, it can be used for sensor fusion as well. It must be mention that this algorithm is deﬁned for linear systems(we used linear algebra). In the case if nonlinear systems, the extended Kalman ﬁlter (EKF) which is a nonlinear version of Kalman ﬁlter can be used.
