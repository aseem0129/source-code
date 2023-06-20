import React, { useState } from 'react';
import axios from 'axios';

function App() {
  const [longUrl, setLongUrl] = useState('');  // State variable for storing the long URL
  const [shortUrl, setShortUrl] = useState('');  // State variable for storing the shortened URL
  const [errorMessage, setErrorMessage] = useState('');  // State variable for storing error messages

  const handleSubmit = async (event) => {
    event.preventDefault();  // Prevent the default form submission behavior
    setErrorMessage('');  // Clear any existing error message

    try {
      const response = await axios.post('http://localhost:5000/shorten', {
        long_url: longUrl,
      });  // Send a POST request to the backend server to shorten the URL
      const shortId = response.data;  // Get the generated short ID from the response
      setShortUrl(`http://localhost:5000/${shortId}`);  // Set the shortened URL in the state variable
    } catch (error) {
      setErrorMessage('Error occurred. Please try again.');  // Set the error message in case of an error
      console.error(error);
    }
  };

  return (
    <div className="container">
      <h1>URL Shortener</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          value={longUrl}
          onChange={(event) => setLongUrl(event.target.value)}
          placeholder="Enter a long URL"
          className="url-input"
        />
        <button type="submit" className="submit-button">Shorten</button>
      </form>
      {errorMessage && <p className="error-message">{errorMessage}</p>}  // Display error message if it exists
      {shortUrl && (
        <div className="result-container">
          <h3>Shortened URL:</h3>
          <a href={shortUrl} target="_blank" rel="noopener noreferrer" className="short-url">
            {shortUrl}
          </a>
        </div>
      )}
    </div>
  );
}

export default App;
