import { closeMainWindow, LaunchProps, showToast, Toast } from "@raycast/api";
import { runAppleScript } from "@raycast/utils";

export default async function Command(props: LaunchProps<{ arguments: Arguments.QuickSearchArc }>) {
  const { query } = props.arguments;
  try {
    await closeMainWindow();
    await searchInArc(query, "personal");
  } catch {
    await showToast({
      style: Toast.Style.Failure,
      title: "Failed opening Arc",
    });
  }
}

export async function searchInArc(query: string, space?: string) {
  const url = query.startsWith("http") ? query : `https://www.google.com/search?q=${encodeURIComponent(query)}`;

  await runAppleScript(`
    tell application "System Events"
      -- Check if Arc is running
      set arcRunning to (exists (processes where name is "Arc"))
    end tell

    -- If Arc is not running, start it
    if not arcRunning then
      tell application "Arc" to activate
      delay 0.2 -- Wait a moment for the app to launch
    end if

    tell application "Arc"
      -- Ensure there's at least one window open
      if (count of windows) is 0 then
        make new window
      end if

      tell front window
        -- If a space is specified, try to focus that space (space logic needs to be more specific)
        ${space ? `tell space "${space}" to focus` : ""}

        -- Open a new tab with the generated URL
        make new tab with properties {URL:"${url}"}
      end tell

      activate
    end tell
  `);
}
