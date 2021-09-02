import { render, screen } from '@testing-library/react';
import App from './App';

test('show the react', () => {
  render(<App />);
  const linkElement = screen.getByText(/react/i);
  expect(linkElement).toBeInTheDocument();
});
