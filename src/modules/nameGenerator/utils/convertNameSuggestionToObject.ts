export class ConvertNameSuggestionToObject {
    convertToObject(suggestion: string): { names: string[] } {
        const trimmedString = suggestion.trim();
        const lines = trimmedString.split('\n');
        const names = lines.map((line) => line.replace(/^\d+\. /, ''));

        return { names };
    }
}